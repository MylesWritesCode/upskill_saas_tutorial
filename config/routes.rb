Rails.application.routes.draw do
  # root to path denoting the root directory of a website (www.example.com as opposed to www.example.com/home) showing the home view from the pages controller.
  root to: 'pages#home'
  # Devise routes, included registrations controller made by us.
  devise_for :users, controllers: { registrations: 'users/registrations' }
  # User resource route to a single profile.
  resources :users do
    resource :profile
  end
  # Route that gets about requests and pulls the about view in the pages controller.
  get 'about', to: 'pages#about'
  # Demonstrating the use of resources when creating routes to a corresponding controller, and limiting the amount of routes created with either an array or single verb.
  resources :contacts, only: :create
  # Added 'as' just to demonstrate that you can change the routes file instead of changing the whole website's code to fix links.
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end