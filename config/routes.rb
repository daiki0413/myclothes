Rails.application.routes.draw do
  get "/", to:"clothes#index"
  get "/new", to:"clothes#new"
  post "/create", to:"clothes#create"
  get "/item/:id/edit", to:"clothes#edit"
  post "/item/:id/update", to:"clothes#update"
  post "/item/:id/destroy", to:"clothes#destroy"

  get "/signup",to:"users#signup"
  post "/users/create",to:"users#create"
  get "/login",to:"users#login_form"
  post "/login",to:"users#login"
  post "/logout",to:"users#logout"

  post "/search", to:"clothes#index"
  get "/category/:id", to:"categories#show"
  get "/statistics/tag",to:"clothes#statistics_tag"
  get "/statistics/color",to:"clothes#statistics_color"
  get "/statistics/season",to:"clothes#statistics_season"
end
