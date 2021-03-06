Birthdayclubjeffcity::Application.routes.draw do
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  match '/dashboard' => 'dashboard/locations#index'
  # match '/users/sign_in' => "birthday_deals#index"
  # match '/users/sign_up' => "birthday_deals#index"
  root :to => 'birthday_deals#index'
  match '/' => "birthday_deals#index", as: 'birthday_deals'
  devise_for :users
  # devise_for :users, :path => '', :path_names => { :sign_in => "sign_in", :sign_out => "sign_out", :sign_up => "sign_up" }
  resources :users, only: [:show, :edit, :update]
  match '/my_account' => "birthday_deals#account", as: 'account' 

  put '/add_birthday_to_user' => 'birthday_deals#add_birthday_to_user'
  match '/' => "birthday_deals#index", as: 'deals'
  resources :birthday_deal_vouchers, only: [:show, :index], path: 'birthday_deals' do
    member do
      put :trash
      put :keep
      get :print
    end
  end

  match '/:geolocation' => 'birthday_deals#index'

  
  namespace :dashboard do
    resources :users  
    resources :companies do  
      resources :company_locations
      member do
        get :archive 
        get :unarchive
      end  
      collection do
        get :archived
        match :search
      end 
      
    end   

    resources :birthday_deal_vouchers, only: [:show, :index], as: "deal_vouchers", path: 'birthday_deals' do
      member do
        put :trash
        put :keep
        get :print
      end
    end

    resources :locations do
      resources :birthday_deals, shallow: true do
        member do
          put :submit_for_approval
          put :withdraw
          put :reject
          put :approve
        end
      end
    end
  end  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
