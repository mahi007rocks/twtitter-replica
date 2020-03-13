class Api::V1::TweetsController < ApplicationController
  before_action :find_user
  
  def index
      
  end

  def follow_and_unfollow
    
  end

  def find_user
    @user = User.find(params[:email])
    render json: {error: "User not found", code: 404} if @user.nil?
  end
end
