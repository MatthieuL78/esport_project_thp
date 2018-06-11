Rails.application.routes.draw do

  get 'partenaire/sponsor'
  root 'home#index'
  get 'rank/index', to: 'rank#index'

  get 'classement/ranking', to: 'classement#ranking'
  get 'partenaire/sponsor', to: 'partenaire#sponsor', as: 'sponsor'

  mount ForestLiana::Engine => '/forest'
  devise_for :sponsors
  devise_for :players
  resources :events

  get 'show_data_event', to: 'events#show_data_event', as: 'show_data_event'
  post 'data_events', to: 'events#save_data_from_spreadsheet', as: 'data_event_create'
  post 'show_scrapp', to: 'events#scrapp_event', as: 'scrapp_event_create'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
