Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  devise_for :sponsors
  devise_for :players
  resources :events
  get 'data_events', to: 'events#data_create', as: 'data_event'
  post 'data_events', to: 'events#save_data_from_spreadsheet', as: 'data_event_create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
