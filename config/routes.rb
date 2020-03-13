Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'tweets/index'
      get 'tweets/follow_and_unfollow'
      get 'tweets/profile'
      get 'tweets/follower_tweets'
    end
  end
  root 'dashboard#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
