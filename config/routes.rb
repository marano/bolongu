ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'home', :action => 'index'
  map.home '/home', :controller => 'home', :action => 'index'
  map.about '/about', :controller => 'home', :action => 'about'
  
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'accounts', :action => 'activate', :activation_code => nil
  map.resource :session, :only => [ :new, :create, :destroy ]
  
  map.send_password '/send_password', :controller => 'accounts', :action => 'send_password', :conditions => { :method => :post }
  map.forgot_password '/forgot_password', :controller => 'accounts', :action => 'forgot_password', :conditions => { :method => :get }
  #map.reset_password '/reset_password', :controller => 'accounts', :action => 'reset_password'

  map.resources :accounts, :except => [ :index, :show ] do |account|
    account.resources :galleries
    account.resources :scraps, :only => [ :index, :create, :show, :destroy ]
  end
  
  map.resources :galleries, :only => [] do |gallery|
    gallery.resources :comments, :only => [ :create, :show, :destroy ]
  end
    
  map.resources :posts, :except => [ :index ] do |post|
    post.resources :comments, :only => [ :create, :show, :destroy ]
  end
  
  map.resources :things, :member => { :add => :post, :remove => :delete} do |thing|
    thing.resources :comments, :only => [ :create, :show, :destroy ]
  end
  
  map.resources :gallery_photos, :except => [ :index, :new ], :collection => { :sort => :post } do |gallery_photo|
    gallery_photo.resources :comments, :only => [ :create, :show, :destroy ]
  end
  
  map.resources :friendships, :only => [ :create, :destroy ]  
  
  map.account_index '/:account_login', :controller => 'accounts', :action => 'account_index', :conditions => { :method => :get }
  
  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
end
