Flapjack::Application.routes.draw do

  devise_for :users

  
  resources :posts, only: [:show]

  #notes
  get "notes/new"
  post "notes", to: "notes#create", as: :notes

  #links
  get "links/new"
  post "links", to: "links#create", as: :links

  #videos
  resources :videos
  #photos
  # get "photos/new"
  # post "photos", to: "photos#create", as: :photos
  resources :photos
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'posts#index'

  post "comments", to: "comments#create", as: :comments


  #follow users by comment
  post 'follow/comment/:id', to: "follows#follow_by_comment"

  get 'follow/user_from_comment/:id', to: "follows#user_id_from_comment_id"


  #last five posts from a user

  get 'posts/five/:id', to: "posts#last_five_from_user"

  get 'posts/:id/last_five_comments', to: "posts#last_five_comments_for_post"



  #check if you are following a user

  get 'follows/:id/followed', to: "follows#user_is_followed"

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
