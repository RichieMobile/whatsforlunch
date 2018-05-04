
defmodule WhatsforlunchWeb.YelpController do
  use WhatsforlunchWeb, :controller

  alias Whatsforlunch.Lunch
  alias Whatsforlunch.Yelp.YelpApi
  alias Whatsforlunch.Yelp.Search
  alias Whatsforlunch.Mapper.SearchResultToRestaurant

  require Logger

  def yelp_search(conn, _params) do
    search = %Search{}
    render(conn, "yelp_search.html", search: search)
  end

  def yelp_add(conn, %{"search" => search_params}) do
    Logger.info("Search params: #{search_params["for"]}")
    case YelpApi.search(search_params["for"]) do
      {:ok, search_result} ->
        search_result
        |> SearchResultToRestaurant.map()
        |> Enum.each(&(Lunch.create_restaurant(&1)))

        conn
        |> put_flash(:info, "Restaurants added from Yelp successfully.")
        |> redirect(to: restaurant_path(conn, :index))
      {:error, message} ->
        conn
        |> put_flash(:info, "Error adding restaurants from Yelp! - #{message}")
        |> redirect(to: restaurant_path(conn, :index))
    end
  end
end