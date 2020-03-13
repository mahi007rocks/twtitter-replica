class Api::V1::TweetsController < ApplicationController
  before_action :find_user
  
  def index
     tweets = @user.tweets
     render json: {user: @user.email , tweets_count: tweets.count ,tweets: tweets.order("created_at DESC"), code: 200}
  end

  def follow_and_unfollow
    
  end

  def follower_tweets
    @follower = @user.followers.where(email: params[:follower_email]).first
    @follower_tweets = @follower.try(:tweets).order("created_at DESC")
    if @follower_tweets.present?
      render json: {user: @user.email, tweets: @follower_tweets, code: 200}
    else
      render json: {error: "follower doesn't have tweets yet", code: 200}
    end
  end

  def profile
    followers = @user.followers
    following = @user.following
    render json: {user: @user.email, followers: followers, following: following, code: 200} 
  end

  def find_user
    @user = User.find_by_email(params[:email])
    render json: {error: "User not found", code: 404} if @user.nil?
  end
end
