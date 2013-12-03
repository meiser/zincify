Zincify::Application.routes.draw do
  
  root :to => "application#start"
  
  
  netzke

  devise_for :users
  
  resources :weighting, :only => [:index, :new] do
	collection do
	 get ':year/:month/:day/:shift' => "weighting#list", :as => 'shift_list', :defaults => { :format => 'html' }
	end
  end
  
  match 'buero' => "application#start"
  match 'waage' => "weighting#new"
  match '/waage/:year/:month/:day/:shift' => "weighting#list", :defaults => { :format => 'html' }
  match '/waage/:year/:month/:day/:shift' => "weighting#list", :as => 'shift_list', :defaults => { :format => 'html' }
  match 'warenannahme' => "application#delivery_control"
  
  match 'abrechnung/:year/:month/:day' => "weighting#calc", :defaults => { :format => 'html' }
  #resources :sort_lists

  #resources :completions

  resources :meiser_deliveries do
	get 'select' => "meiser_deliveries#select", :on => :collection, :as => :select
  end
  
  resources :deliver_references do
	resources :meiser_bundle_tags
  end
	#end
  # do
   
  # post :bundles, :on => :collection, :defaults => { :format => 'json' }
  
  #end
  
  
  scope '/scanner/wa' do
    get '/commission/last' => "scanner_wa#last_commission"
  	get '/commission/check/:commission' => "scanner_wa#check_commission"
	get '/commission/barcode_count/:commission' => "scanner_wa#barcode_count_commission"
	post '/commission/new' => "scanner_wa#new_commission"
	post '/barcode/new' => "scanner_wa#new_barcode"
	post '/barcode/update' => "scanner_wa#update_barcode"
  end
  
  scope 'scanner/waage' do
    get 'categories' => 'scanner_waage#categories', :defaults => { :format => 'json' }
	post 'weighting/new' => 'scanner_waage#new_weighting'
  end
  
  
  
  
  #resources :traverses do
  # get :fill, :on => :collection
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
  
  #match "weighting/poll" => "weighting#poll", :defaults => { :format => 'json' }
  
  match "admin" => "application#admin"

end

