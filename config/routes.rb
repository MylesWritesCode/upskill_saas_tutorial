Rails.application.routes.draw do
    root to: 'pages#home'
    get 'about', to: 'pages#about'
    resources :contacts, only: :create
    get 'contact-us', to: 'contacts#new', as: 'new_contact' # Added as just to demonstrate that you can change the routes file instead of changing the whole website's code to fix links.
end