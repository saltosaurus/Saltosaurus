Saltosaurus::Application.routes.draw do

  mount Bootsy::Engine => '/bootsy', as: 'bootsy'
  devise_for :users, controllers: { omniauth_callbacks: 'user/omniauth_callbacks' }
  get "about/index"
  get "projects/index"
  resources :about

  resources :admin

  resources :collections

  resources :anthologies, controller: 'collections', type: 'Anthology', defaults: { type: 'Anthology' }

  resources :novels, controller: 'collections', type: 'Novel', defaults: { type: 'Novel' }

  resources :comments

  resources :projects

  resources :stories

  resources :short_stories, controller: 'stories', type: 'ShortStory', defaults: { type: 'ShortStory' }, path: '/short'

  resources :chapters, controller: 'stories', type: 'Chapter', defaults: { type: 'Chapter' }

  resources :blog_entries, controller: 'stories', type: 'BlogEntry', defaults: { type: 'BlogEntry' }, path: '/blog'

  resources :users

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
