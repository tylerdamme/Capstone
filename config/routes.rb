Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  namespace :v1 do
    post "/users" => "users#create"
    post "/user_teams" => "user_teams#create"
    post "/news_sources" => "news_sources#create"
    # post "/price_watches" => "price_watches#create"
    patch "/price_watches" => "price_watches#update"
    # delete "/news_sources/:id" => "news_sources#destroy"
    delete "/news_source_by_name" => "news_sources#destroy_by_name"
    delete "/user_teams" => "user_teams#destroy"

    get "/teams" => "teams#index"
    get "/news_sources" => "news_sources#index"
    get "/teams/:id" => "teams#show"
    get "/info" => "team_info#index"
    get "/info/tickets" => "team_info#tickets"
    get "/sports" => "sports#index"
    get "/news_api" => "news_api#index"
    get "/info/text" => "team_info#text"
  end
end
