Diaspora::Application.routes.draw do
  resources :people, :only => [:index, :show, :destroy]
  resources :users, :except => [:create, :new]
  resources :status_messages, :only => [:create, :destroy, :show]
  resources :comments, :except => [:index]
  resources :requests, :except => [:edit, :update]
  resources :photos, :except => [:index]
  resources :albums
  resources :groups

  match 'warzombie',          :to => "dev_utilities#warzombie"
  match 'zombiefriends',      :to => "dev_utilities#zombiefriends"
  match 'zombiefriendaccept', :to => "dev_utilities#zombiefriendaccept"
  match 'set_backer_number', :to => "dev_utilities#set_backer_number"

  #routes for devise, not really sure you will need to mess with this in the future, lets put default,
  #non mutable stuff in anohter file
  devise_for :users
  match 'login',  :to => 'devise/sessions#new',      :as => "new_user_session"
  match 'logout', :to => 'devise/sessions#destroy',  :as => "destroy_user_session"
  match 'get_to_the_choppa', :to => 'devise/registrations#new', :as => "new_user_registration"
  
  #public routes
  #
  match 'webfinger', :to => 'publics#webfinger'
  match 'users/:id/hcard',    :to => 'publics#hcard'

  match '.well-known/host-meta',:to => 'publics#host_meta'        
  match 'receive/users/:id',     :to => 'publics#receive'    
  #root
  root :to => 'groups#index'
end
