Zincify::Application.routes.draw do
  
  #devise_scope :user do
#	root :to => "devise/sessions#new"
 # end
  
  root :to => "application#start"
  
  netzke

  devise_for :users

  #resources :sort_lists

  #resources :completions

  #resources :traverses do
  # get :fill, :on => :collection
  #end

  resources :deliveries do
   get :received, :on => :collection
   post :print, :on => :member
  end

  #resources :bookings

  #resources :commissions

  resources :next_free_numbers
  
  resource :user, :only => [:edit, :update] do
    post :printer
  end

  resource :printer, :only => :update

end

