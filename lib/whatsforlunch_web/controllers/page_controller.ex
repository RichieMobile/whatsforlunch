defmodule WhatsforlunchWeb.PageController do
  use WhatsforlunchWeb, :controller
  alias Whatsforlunch.Lunch
  require Logger

  def index(conn, _params) do
    render conn, "index.html"
  end

  def random(conn, _params) do
    Logger.info("Getting random restaurant")
    restaurants = Lunch.list_restaurants
    number = :rand.uniform(length(restaurants)) - 1 
    restaurant = Enum.at(restaurants, number)
    render(conn, "random.html", restaurant: restaurant)
  end
end
