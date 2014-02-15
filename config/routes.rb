Utour::Application.routes.draw do
  get "images/index"
  get "images/show"
  get "images/create"
  get "images/destroy"
  resources :date_and_prices

  resources :tours do
    get 'legacy', on: :member
  end

  resources :bookings do
    get 'account_specific_index', on: :collection
  end

  resources :accounts do
    get 'activate_show', on: :member
    post 'activate', on: :member
  end

  #resources :user_groups

  resources :sessions, only: [:new, :create, :destroy]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'wechat_webs#lion'

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
  match '/lion', to: 'wechat_webs#lion', via: 'get'
  match '/tiger/group_travel', to: 'wechat_webs#group_travel', via: 'get'
  match '/lion/group_travel', to: 'wechat_webs#group_travel', via: 'get'
  match '/lion/visa', to: 'wechat_webs#visa', via: 'get'
  match '/lion/trade', to: 'wechat_webs#trade', via: 'get'
  match '/lion/contact', to: 'wechat_webs#contact', via: 'get'
  match '/lion/feedback', to: 'wechat_webs#feedback', via: 'post'
  match '/lion/diy', to: 'wechat_webs#diy', via: 'get'
  match '/lion/sale', to: 'wechat_webs#sale', via: 'get'
  match '/lion/guide', to: 'wechat_webs#guide', via: 'get'


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
    resources :tours
    resources :bookings
    resources :user_groups
    resources :date_and_prices
    resources :shelves

    resources :feature_tag_connections, only: [:new, :create, :destroy, :index]
    resources :feature_tags, only: [:new, :create, :destroy, :index]
    resources :invitation_codes, only: [:new, :create, :destroy, :index]
    resources :images, only: [:create, :destroy, :index]

    resources :invitation_codes do |invitation_code|
      get 'cancel', on: :member
    end
    
    resources :sessions, only: [:new, :create, :destroy]

    get '/', to: 'plateforms#dashboard'
    get '/home', to: 'plateforms#home'
    get '/inbox', to: 'plateforms#inbox'
    get '/email_list', to: 'plateforms#email_list'
    get '/email_compose', to: 'plateforms#email_compose'
    get '/calendar', to: 'plateforms#calendar'
    get '/invitation_code_control', to: 'plateforms#invitation_code_control'
    get '/account_control', to: 'plateforms#account_control'

    get '/account_admin', to: 'plateforms#account_admin'
    get '/new_tour', to: 'plateforms#new_tour'
    get '/edit_tour', to: 'plateforms#edit_tour'
    get '/index_tour', to: 'plateforms#index_tour'

    get '/new_shelf', to: 'plateforms#new_shelf'
    get '/edit_shelf', to: 'plateforms#edit_shelf'
    get '/index_shelf', to: 'plateforms#index_shelf'

    get '/tag_control', to: 'plateforms#tag_control'
    get '/date_and_price_control', to: 'plateforms#date_and_price_control'
    get '/image_admin', to: 'plateforms#image_admin'

      match '/signup',  to: 'accounts#new', via: 'get'
      match '/signin',  to: 'sessions#new', via: 'get'
      match '/signout', to: 'sessions#destroy', via: 'delete'
  end
end
