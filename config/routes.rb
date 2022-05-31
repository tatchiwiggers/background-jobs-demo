Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # Sidekiq Web UI, only for admins.
  # waqui fazemos o import necessario para criar o dashboard do admin
  require "sidekiq/web"
  # se o usuario é admin, a rota vai existir, caso contrario ela nao vai existir
  authenticate :user, ->(user) { user.admin? } do
    # aqui nos criamos a rota para acessar o dashboard de admins para a URI '/sidekiq'
    mount Sidekiq::Web => '/sidekiq'
  end
end
