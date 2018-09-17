# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get '/groups/work/:filter', to: 'groups#work'
      resources :groups do
        get '/tasks/tasks_done', to: 'tasks#tasks_done'
        resources :tasks
        resources :schedulings
      end

      resource :auth, only: %i[create]
    end
  end
end
