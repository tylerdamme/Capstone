Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  namespace :v1 do
    post "/users" => "users#create"

    post "/news_sources" => "news_sources#create"
    delete "/news_sources/:id" => "news_sources#destroy"

    get "/teams" => "teams#index"
    get "/teams/:id" => "teams#show"
  end
end
