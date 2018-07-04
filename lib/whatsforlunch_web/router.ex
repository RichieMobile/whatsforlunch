defmodule WhatsforlunchWeb.Router do
  use WhatsforlunchWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WhatsforlunchWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/random", PageController, :random
    get "/random_selection", PageController, :random_selection
    post "/random_range", PageController, :random_range

    resources "/restaurants", RestaurantController

    get "/yelp_search", YelpController, :yelp_search
    post "/yelp_add", YelpController, :yelp_add
  end

  # Other scopes may use custom stacks.
  # scope "/api", WhatsforlunchWeb do
  #   pipe_through :api
  # end
end
