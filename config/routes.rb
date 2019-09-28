Rails.application.routes.draw do
  
	root 'static_pages#home'
  get '/contact', to: 'static_pages#contact'
  get '/team', to: 'static_pages#team'
  get '/bienvenue/:first_name', to: 'static_pages#bienvenue', as: 'bienvenue'
  get '/gossip/:id', to: 'gossip#show', as: 'gossip_show'
  get 'user/:id', to: 'user#show', as: 'user_show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
