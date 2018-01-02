Rails.application.routes.draw do
  post 'user_token' => 'user_token#create'
  namespace :v1 do
    post "/users" => "users#create"

    get "/teams" => "teams#index"
    get "/teams/:id" => "teams#show"
  end
end
