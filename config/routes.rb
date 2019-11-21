Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      post '/signup' => 'users#create', :as => :user
      post '/login' => 'authentication#authenticate'
      put '/users' => 'users#update'
      get '/events/user' => 'events#user'
      resources :users, except: [:show, :create, :update]
      resources :events
      resources :attendings, only: [:create]
      resources :categories, only: [:index]
      delete '/attendings' => 'attendings#destroy'
      get 's3/direct_post' => 's3#direct_post'
      delete 's3/delete' => 's3#destroy'
    end
  end
end
