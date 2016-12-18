Rails.application.routes.draw do


  get 'dashboard' => 'goals#dashboard', as: :dashboard
  get 'calendar' => 'goals#calendar', as: :calendar
  get 'goals/:id/task/:task_id' => 'goals#task', as: :goal_task
  get 'goals/new' => 'goals#new', as: :new_goal
  get 'goals/my' => 'goals#my'
  get 'goals/:id' => 'goals#show', as: :goal
  post 'goals/enroll/:goal_template_id' => 'goals#enroll', as: :enroll_goal
  delete 'goals/:id' => 'goals#destroy'

  get 'tasks' => 'tasks#index'
  get 'tasks/show'
  post 'tasks/complete/:id/goal/:goal_id' => 'tasks#complete', as: :complete_task
  post 'tasks/schedule/:id/goal/:goal_id' => 'tasks#schedule', as: :schedule_task

  resources :tasks, only: [:show]
  resources :goal_templates
  root to: 'goals#dashboard'

  get 'register' => 'sessions#register_form'
  post 'register' => 'sessions#register', as: :register_user
  get 'login' => 'sessions#login_form'
  post 'login' => 'sessions#login', as: :login_user
  get 'logout' => 'sessions#logout', as: :logout_user

  resources :users, except: [:new, :edit] do
    collection do
      get :profile
      post :profile, to: 'users#update_profile'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
