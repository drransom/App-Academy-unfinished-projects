class UsersController < ApplicationController
  def index
    render json: { 'cat' => 'lion' }
  end
end
