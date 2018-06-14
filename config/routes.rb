Rails.application.routes.draw do
  get 'statistique/index'
  root 'home#index'

  get 'partenaire/sponsor'
  get 'home/profil-user', to: 'home#profil-user', as: 'profil'

  get 'classement/ranking', to: 'classement#ranking'
  get 'classement/fullranking', to: 'classement#fullranking'
  get 'classement/profil-player', to: 'classement#profil-player'

  get 'partenaire/sponsor', to: 'partenaire#sponsor', as: 'sponsor'

  mount ForestLiana::Engine => '/forest'
  devise_for :sponsors
  devise_for :players
  resources :events

  get 'show_data', to: 'datas#show_data', as: 'show_data_event'
  post 'scrapp_data/:scrapp_id', to: 'datas#scrapp_datas', as: 'scrapp_datas'
  post 'save_data/:save_id', to: 'datas#save_ws_on_db', as: 'save_events'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
