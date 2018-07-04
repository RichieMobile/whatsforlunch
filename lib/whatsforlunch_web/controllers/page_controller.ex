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

    restaurants = Lunch.list_restaurants
    {count, _param} = Integer.parse(params["count"])

    if count > length(restaurants) do
      render_restuarants restaurants, conn, "random_range.html"
    else 
      get_random_range_of_unique_indexes(Map.new, length(restaurants), count)
      |> Enum.map(&(Enum.at(restaurants, &1)))
      |> render_restuarants(conn, "random_range.html")
    end
  end

  defp get_random_restaurants([], _range) do
    Logger.info("No restaurants configured, displaying error.")
    %Lunch.Restaurant{name: "Oops!", location: "No restaurants configured"}
  end

  defp get_random_range_of_unique_indexes(map, max_range, number) do
    n = :rand.uniform(max_range) - 1 
    length = length(Map.keys(map))
    cond do
      length == number -> 
        Logger.info("Generated unique key list")
        Map.keys map
      !Map.has_key?(map, n) ->
        Map.put(map, n, n)
        |> get_random_range_of_unique_indexes(max_range, number)
      true ->
        get_random_range_of_unique_indexes(map, max_range, number)
    end
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
