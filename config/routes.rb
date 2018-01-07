Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  namespace :v1 do
    post "/users" => "users#create"

    post "/news_sources" => "news_sources#create"
    # delete "/news_sources/:id" => "news_sources#destroy"
    delete "/news_source_by_name" => "news_sources#destroy_by_name"

    get "/teams" => "teams#index"
    get "/news_sources" => "news_sources#index"
    get "/teams/:id" => "teams#show"

    get "/news_api" => "news_api#index"
  end
end
