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

  get 'show_data', to: 'datas#show_data', as: 'show_data_event'
  post 'show_data', to: 'datas#scrapp_events', as: 'scrapp_events'
  post 'show_data', to: 'datas#scrapp_players', as: 'scrapp_players'
  post 'show_data', to: 'datas#scrapp_games', as: 'scrapp_datas'
  post 'show_data', to: 'datas#save_data_from_spreadsheet_event', as: 'save_events'
  post 'show_data', to: 'datas#save_data_from_spreadsheet_player', as: 'save_players'
  post 'show_data', to: 'datas#save_data_from_spreadsheet_game', as: 'save_games'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
