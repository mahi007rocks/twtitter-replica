class Api::V1::TweetsController < ApplicationController
  before_action :find_user
  
  def index
     tweets = @user.tweets
     render json: {user: @user.email , tweets_count: tweets.count ,tweets: tweets.order("created_at DESC"), code: 200}
  end

  def follow_and_unfollow
    follow_user = User.find_by_email(params[:follower][:email])
    if params[:follow] == "no" 
      @user.followed_relationships.find_by(followed_id: other_user.id).destroy
    else params[:follow] == "yes"
      if @user.following.include?(follow_user)
        render json: {msg: "Already following the user", code: 200}
      else
        if follow_user.present?
          Relationship.create(follower_id: @user.try(:id), followed_id: follow_user.id)
          render json: {user: @user.email, follower: follow_user.email}
        else
          render json: {alert: "User not found", code: 200}
        end
      end
    end
    
  end

  def follower_tweets
    @follower = @user.followers.where(email: params[:follower_email]).first
    @follower_tweets = @follower.try(:tweets).order("created_at DESC")
    if @follower_tweets.present?
      render json: {user: @user.email, tweets: @follower_tweets, code: 200}
    else
      render json: {error: "follower don't have tweets yet", code: 200}
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
