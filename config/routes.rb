Rails.application.routes.draw do
  scope '/api' do
    resources :users, except: [:index]
    resources :events
    resources :attendings, only: [:create, :destroy]
  end
end
