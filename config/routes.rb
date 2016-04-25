Rails.application.routes.draw do
  devise_for :users, skip: [:sessions, :registrations]
  devise_scope :user do
    resource :registration, only: [:create, :update, :destroy],
             path: 'users', controller: 'auth/registrations'
    resource :session, only: [:create], path: 'sign-in',
             controller: 'auth/sessions'
  end
  resources :users, only: [:index, :show]
  resources :topics, except: [:new, :edit]
  resources :documents, except: [:new, :edit]
  resources :courses, except: [:new, :edit]
  resources :images, only: [:create]
  post 'documents/:id/upload' => 'documents#upload'
  post 'documents/:id/file-request' => 'documents#file_request'
  post 'documents/:id/css' => 'documents#css_upload'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
