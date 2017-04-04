Rails.application.routes.draw do
  # match '*path' => 'application#handle_options_request', via: :options
  resources :todos
  match '/todos' => 'todos#destroy_all', via: :delete
end
