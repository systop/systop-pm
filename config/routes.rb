Rails.application.routes.draw do

  resources :updates
  resources :categories
  mount Ckeditor::Engine => '/ckeditor'
  resources :tasks
  resources :roles
  resources :logs
  resources :projects
  # resources :projects do
  #   resources :categories
  # end




  # resources :projects do
  #   collection do
  #     post :destroy_role
  #   end
  # end

  resources :admin_settings

  devise_for :users, controllers: {
    #user's page
    registrations: 'users/registrations',
    #added logs
    sessions: 'users/sessions'
  }

  devise_scope :user do
    #user's page
    match 'users/:id/show', to: 'users/registrations#show', via: :get, as: "user_show"
    #list of all users
    match 'users/', to: 'users/registrations#index', via: :get, as: "users_index"
    #edit user via admin (form)
    match 'users/:id/admin_edit', to: 'users/registrations#admin_edit', via: :get, as: "user_admin_edit"
    #update with data from form
    match 'users/:id/admin_update', to: 'users/registrations#admin_update', via: :patch, as: "user_admin_update"
  end

  root 'home#index'
end
