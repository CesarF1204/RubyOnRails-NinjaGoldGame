Rails.application.routes.draw do
  root 'rpg#index'
  post 'process' => 'rpg#process_gold'
  get 'reset' => 'rpg#restart_game'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
