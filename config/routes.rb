Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :group_sessions, only: [:create, :destroy]
    end
  end
  mount API::Base => '/'
end
