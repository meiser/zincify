Zincify::Application.routes.draw do
  
  root :to => "application#start"
  
  
  netzke

  devise_for :users
  
  resources :weighting, :only => [:index, :new, :edit] do
	collection do
	 get ':year/:month/:day/:shift' => "weighting#list", :as => 'shift_list', :defaults => { :format => 'html' }
	end
  end

  #resources :sort_lists

  #resources :completions

  #resources :traverses do
  # get :fill, :on => :collection
  #end

  #resources :meiser_deliveries do
  #  post 
  #end

  #resources :deliveries do
  # get :received, :on => :collection
  # post :print, :on => :member
  #end

  #resources :bookings

  #resources :commissions

  #resources :next_free_numbers
  
  #resource :user, :only => [:edit, :update] do
  #  post :printer
  #end

  #resource :printer, :only => :update
  
  match "weighting/poll" => "weighting#poll", :defaults => { :format => 'json' }
  
  match "admin" => "application#admin"

end

