class UsersController < ApplicationController
  include Pagy::Backend

  def index
    @pagination, @users = pagy(User.all)
  end
end
