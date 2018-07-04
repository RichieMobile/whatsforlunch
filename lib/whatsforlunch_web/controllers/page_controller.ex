defmodule WhatsforlunchWeb.PageController do
  use WhatsforlunchWeb, :controller
  alias Whatsforlunch.Lunch
  require Logger

  def index(conn, _params) do
    render conn, "index.html"
  end

  def random_selection(conn, _params) do
    render(conn, "random_selection.html")
  end

  def random_range(conn, params) do
    Logger.info("Getting random range of restaurants: #{params["count"]}")

    Lunch.list_restaurants
    |> get_random_restaurants(params["count"])
    |> render_restuarants(conn, "random_range.html")
  end

  defp get_random_restaurants([], _range) do
    Logger.info("No restaurants configured, displaying error.")
    %Lunch.Restaurant{name: "Oops!", location: "No restaurants configured"}
  end

  defp get_random_restaurants(restaurants, range) do
    {rangeInt, _ok} = Integer.parse(range)
    rests = Enum.map(1..rangeInt, fn(_a) -> get_random_restaurant(restaurants) end)
    IO.inspect(rests)
    rests
  end

  defp render_restuarants(restaurants, conn, template) do
    render(conn, template, restaurants: restaurants)
  end

  def random(conn, _params) do
    Logger.info("Getting random restaurant")

    Lunch.list_restaurants
    |> get_random_restaurant
    |> render_restuarant(conn, "random.html")
  end

  defp get_random_restaurant([]) do
    Logger.info("No restaurants configured, displaying error.")
    %Lunch.Restaurant{name: "Oops!", location: "No restaurants configured"}
  end

  defp get_random_restaurant(restaurants) do
    number = :rand.uniform(length(restaurants)) - 1 
    Enum.at(restaurants, number)
  end

  defp render_restuarant(restaurant, conn, template) do
    render(conn, template, restaurant: restaurant)
  end
end
