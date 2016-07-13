Rails.application.routes.draw do
  
  
  post 'products/agotado' => 'products#agotado', as: :producto_agotado
  post 'products/en_stock' => 'products#en_stock', as: :hay_stock_producto
  get 'products/search' => 'products#search',as: :products_search

  resources :products

  get 'interactions/respondidas' => 'interactions#respondidas',as: :preguntas_respondidas
  get 'interactions/sin_responder' => 'interactions#sin_responder',as: :preguntas_sin_responder
  get 'interactions/mis_respondidas' => 'interactions#mis_respondidas',as: :preguntas_mias_respondidas
  get 'interactions/mis_sin_responder' => 'interactions#mis_sin_responder',as: :preguntas_mias_sin_responder

  resources :interactions

  post 'orders/entregar' => 'orders#entregar_orden', as: :deliver_order
  post 'orders/autorizar' => 'orders#autorizar_orden', as: :authorize_order
  get 'orders/sin_autorizar_todas' => 'orders#ordenes_sin_autorizar_todas', as: :ordenes_sin_autorizar_todas
  get 'orders/sin_autorizar' => 'orders#ordenes_sin_autorizar', as: :ordenes_sin_autorizar
  get 'orders/mias_sin_entregar' => 'orders#ordenes_mias_autorizadas_sin_entregar', as: :ordenes_mias_sin_entregar
  get 'orders/mias_entregadas' => 'orders#ordenes_mias_entregadas', as: :ordenes_mias_entregadas
  get 'orders/a_autorizar_x_mi' => 'orders#ordenes_a_autorizar_x_mi', as: :mis_ordenes_para_autorizar
  get 'orders/sin_entregar' => 'orders#ordenes_autorizadas_sin_entregar', as: :ordenes_sin_entregar
  get 'orders/entregadas' => 'orders#ordenes_entregadas', as: :ordenes_entregadas
  
  resources :orders
  
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions'}
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'products#index'




  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  # 
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
  #     #   end
end
