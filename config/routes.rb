Rails.application.routes.draw do
  root to: 'todos#index', via: :get
  root to: 'todos#create', via: :post
  root to: 'todos#destroy_all', via: :delete
  match '/:id' => 'todos#show', via: :get
  match '/:id' => 'todos#update', via: :patch
  match '/:id' => 'todos#destroy', via: :delete
end
