Rails.application.routes.draw do
  namespace :mock do
    get 'users/login'
    get 'users/index'
    get 'users/show'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
