require 'sidekiq-scheduler'

class ImportUsersWorker
  include Sidekiq::Worker
  include Pagy::Backend

  sidekiq_options queue: 'low', retry: true

  def perform
    users_list.each do |user|
      User.find_or_create_by(reference_key: user.dig('id'), 
                             name: user.dig('name'),
                             age: user.dig('age'),
                             email: user.dig('email'))
    end

    pagination, users = pagy(User.all, page: 1)
    broadcast_to_user_list(users, pagination)
  end

  private

  def users_list
    connection.get('json').body.dig('users')
  end

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
