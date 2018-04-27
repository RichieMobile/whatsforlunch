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
    resources "/restaurants", RestaurantController
  end

  # Other scopes may use custom stacks.
  # scope "/api", WhatsforlunchWeb do
  #   pipe_through :api
  # end
end
