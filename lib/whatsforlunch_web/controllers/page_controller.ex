defmodule WhatsforlunchWeb.PageController do
  use WhatsforlunchWeb, :controller
  alias Whatsforlunch.Lunch
  require Logger

  def index(conn, _params) do
    render conn, "index.html"
  end

  def random(conn, _params) do
    Logger.info("Getting random restaurant")
    restaurant = case Lunch.list_restaurants do
      [] ->
        %Lunch.Restaurant{name: "Oops!", location: "No restaurants configured"}
      restaurants ->
        number = :rand.uniform(length(restaurants)) - 1 
        restaurant = Enum.at(restaurants, number)
    end
    render(conn, "random.html", restaurant: restaurant)
  end
end
