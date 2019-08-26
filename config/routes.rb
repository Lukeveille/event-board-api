Rails.application.routes.draw do
  scope '/api' do
    scope '/v1' do
      post '/signup' => 'users#create', :as => :user
      post '/login' => 'authentication#authenticate'
      put '/users' => 'users#update'
      resources :users, except: [:index, :show, :create, :update]
      resources :events
      resources :attendings, only: [:index, :show, :create]
      delete '/attendings' => 'attendings#destroy'
      get 's3/direct_post' => 's3#direct_post'
    end
  end
end
