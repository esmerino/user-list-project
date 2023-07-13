require 'sidekiq-scheduler'

class ImportUsersWorker
  include Sidekiq::Worker
  include Pagy::Backend

  sidekiq_options queue: 'low', retry: true

  def perform
    users_list = connection.get('json').body.dig('users')

    users_list.each do |user|
      User.find_or_create_by(reference_key: user['id'], 
                             name: user['name'],
                             age: user['age'],
                             email: user['email'])
    end

    pagination, users = pagy(User.all, page: 1)
    broadcast_to_user_list(users, pagination)
  end

  private

  def connection
    @connection ||= Faraday.new('https://run.mocky.io/v3/ce47ee53-6531-4821-a6f6-71a188eaaee0') do |conn|
      conn.response :json
    end
  end

  def broadcast_to_user_list(users, pagination)
    Turbo::StreamsChannel.broadcast_replace_to("user_list",
                                               target: 'loading-user_list',
                                               partial: 'users/user_list',
                                               locals: { users: users, pagination: pagination })
  end
end
