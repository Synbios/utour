Utour::Application.routes.draw do

  resources :date_and_prices

  resources :tours do
    get 'legacy', on: :member
    get 'show_docx', on: :member
  end

  resources :bookings do
    get 'account_specific_index', on: :collection
  end

  resources :accounts do
    get 'activate_show', on: :member
    post 'activate', on: :member
  end

  resources :agents

  resources :images, only: [:show]

  #resources :user_groups

  resources :sessions, only: [:new, :create, :destroy]

  resources :visa_infos, only: [:show]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'front30#home'

  match '/signup',  to: 'accounts#new', via: 'get'
  match '/signin',  to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/signout', to: 'sessions#destroy', via: 'get'

  match '/legacy/home', to: 'legacies#home', via: 'get'

  match '/legacy/group_tours', to: 'legacies#group_tours', via: 'get'
  match '/legacy/free_tours', to: 'legacies#free_tours', via: 'get'
  match '/legacy/assorted', to: 'legacies#assorted', via: 'get'
  match '/legacy/visa', to: 'legacies#visa', via: 'get'
  match '/legacy/my_booking', to: 'legacies#my_booking', via: 'get'
  match '/legacy/booking_status', to: 'legacies#booking_status', via: 'get'
  match '/legacy/info', to: 'legacies#info', via: 'get'
  match '/legacy/guide', to: 'legacies#guide', via: 'get'

  # wechat API routs
  match '/wechat', to: 'wechats#check', via: 'get'
  match '/wechat', to: 'wechats#message', via: 'post'
  match '/wechat/debug', to: 'wechats#debug', via: 'get'

  # Tiger
  match '/tiger', to: 'wechat_webs#tiger', via: 'get'
  # lion
  match '/lion', to: 'wechat_webs#lion', via: 'get'
  match '/tiger/group_travel', to: 'wechat_webs#group_travel', via: 'get'
  match '/lion/group_travel', to: 'wechat_webs#group_travel', via: 'get'
  match '/lion/visa', to: 'wechat_webs#visa', via: 'get'
  match '/lion/trade', to: 'wechat_webs#trade', via: 'get'
  match '/lion/video', to: 'wechat_webs#video', via: 'get'
  match '/lion/contact', to: 'wechat_webs#contact', via: 'get'
  match '/lion/feedback', to: 'wechat_webs#feedback', via: 'post'
  match '/lion/diy', to: 'wechat_webs#diy', via: 'get'
  match '/lion/sale', to: 'wechat_webs#sale', via: 'get'
  match '/lion/guide', to: 'wechat_webs#guide', via: 'get'
  get '/lion/visa_detail', to: 'wechat_webs#visa_detail'

  get '/landing_page', to: 'front30#landing_page'
  # Front30

  get '/front30/home', to: 'front30#home'
  get '/front30/contact_about', to: 'front30#contact_about'
  get '/front30/about', to: 'front30#about'
  get '/front30/dm', to: 'front30#dm'
  get '/front30/video', to: 'front30#video'
  get '/front30/travel_guide', to: 'front30#travel_guide'
  get '/front30/group', to: 'front30#group'
  get '/front30/free', to: 'front30#free'
  get '/front30/onsale', to: 'front30#onsale'
  get '/front30/quick_booking', to: 'front30#quick_booking'
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleablep
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  namespace :admin do |admin|
    
    resources :accounts
    resources :admins
    resources :operators
    resources :sales
    resources :agents

    resources :tours do
      resources :departures do 
        resources :prices
      end
    end
    resources :bookings
    resources :user_groups
    resources :date_and_prices
    resources :shelves

    resources :feature_tag_connections, only: [:new, :create, :destroy, :index]
    resources :feature_tags, only: [:new, :create, :destroy, :index]
    resources :invitation_codes, only: [:new, :create, :destroy, :index]
    resources :images, only: [:create, :destroy, :index]
    resources :sites
    resources :activities
    resources :days

    resources :visa_infos, only: [:new, :create, :destroy, :index]
    

    resources :invitation_codes do |invitation_code|
      get 'cancel', on: :member
    end
    
    resources :sessions, only: [:new, :create, :destroy]

    resources :sale_channels, only: [:create, :destroy, :update, :index]
    resources :sale_channel_maps, only: [:create, :destroy]

    get '/', to: 'plateforms#dashboard'
    get '/home', to: 'plateforms#home'
    get '/inbox', to: 'plateforms#inbox'
    get '/email_list', to: 'plateforms#email_list'
    get '/email_compose', to: 'plateforms#email_compose'
    get '/calendar', to: 'plateforms#calendar'
    get '/invitation_code_control', to: 'plateforms#invitation_code_control'
    get '/account_control', to: 'plateforms#account_control'

    get '/staff_index', to: 'plateforms#staff_index'
    get '/agent_index', to: 'plateforms#agent_index'
    get '/booking_index', to: 'plateforms#booking_index'
    get '/new_tour', to: 'plateforms#new_tour'
    get '/edit_tour', to: 'plateforms#edit_tour'
    get '/index_tour', to: 'plateforms#index_tour'

    get '/new_shelf', to: 'plateforms#new_shelf'
    get '/edit_shelf', to: 'plateforms#edit_shelf'
    get '/decorate_tour', to: 'plateforms#decorate_tour'
    get '/index_shelf', to: 'plateforms#index_shelf'

    get '/tag_control', to: 'plateforms#tag_control'
    get '/date_and_price_control', to: 'plateforms#date_and_price_control'
    get '/image_admin', to: 'plateforms#image_admin'
    get '/site_admin', to: 'plateforms#site_admin'
    get '/new_site_admin', to: 'plateforms#new_site_admin'

    get '/get_image_url', to: 'images#get_image_url'
    get '/get_image_list_by_site_id', to: 'sites#get_image_list_by_site_id'

    get '/departure_admin', to: 'plateforms#departure_admin'
    get '/price_admin', to: 'plateforms#price_admin'

    get '/sale_channels_admin', to: 'plateforms#sale_channels_admin'
    get '/agents_admin', to: 'plateforms#agents'
    get '/bookings_admin', to: 'plateforms#bookings_admin'
    get '/my_invitation_code', to: 'plateforms#my_invitation_code'

      match '/signup',  to: 'accounts#new', via: 'get'
      match '/signin',  to: 'sessions#new', via: 'get'
      match '/signout', to: 'sessions#destroy', via: 'delete'
  end
end
