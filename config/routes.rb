Rails.application.routes.draw do
  scope '/api' do
    post '/signup' => 'users#create', :as => :user
    post '/login' => 'authentication#authenticate'
    put '/users' => 'users#update'
    resources :users, except: [:index, :show, :create, :update]
    resources :events
    resources :attendings, only: [:create], as: :attending
    delete '/attendings' => 'attendings#destroy'
  end
end
