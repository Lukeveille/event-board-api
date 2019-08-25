Rails.application.routes.draw do
  scope '/api' do
    post '/signup' => 'users#create', :as => :user
    post '/login' => 'users#show'
    resources :users, except: [:index, :create]
    resources :events
    resources :attendings, only: [:create, :destroy]
  end
end
