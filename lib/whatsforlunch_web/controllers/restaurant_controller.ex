defmodule WhatsforlunchWeb.RestaurantController do
  use WhatsforlunchWeb, :controller

  alias Whatsforlunch.Lunch
  alias Whatsforlunch.Lunch.Restaurant
  alias Whatsforlunch.Yelp.YelpApi

  require Logger

  def index(conn, _params) do
    restaurants = Lunch.list_restaurants()
    render(conn, "index.html", restaurants: restaurants)
  end

  def new(conn, _params) do
    changeset = Lunch.change_restaurant(%Restaurant{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"restaurant" => restaurant_params}) do
    case Lunch.create_restaurant(restaurant_params) do
      {:ok, restaurant} ->
        conn
        |> put_flash(:info, "Restaurant created successfully.")
        |> redirect(to: restaurant_path(conn, :show, restaurant))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def yelp_search(conn, %{"search" => search_params}) do
    case YelpApi.search(search_params) do
      {:ok, search_result} ->
        search_result.businesses
        |> map_search_result_to_restaurant()
        |> Enum.each(&(Lunch.create_restaurant(&1)))
      {:error, message} ->
        Logger.info("Error searching yelp: #{message}")
    end
  end

  defp map_search_result_to_restaurant([]), do: []
  defp map_search_result_to_restaurant(business) do
    Enum.map(business, fn(x) -> 
      %Restaurant{
        name: x.name,
        website: x.url,
        location: Enum.at(x.location.display_address, 0)
      }
    end)
  end

  def show(conn, %{"id" => id}) do
    restaurant = Lunch.get_restaurant!(id)
    render(conn, "show.html", restaurant: restaurant)
  end

  def edit(conn, %{"id" => id}) do
    restaurant = Lunch.get_restaurant!(id)
    changeset = Lunch.change_restaurant(restaurant)
    render(conn, "edit.html", restaurant: restaurant, changeset: changeset)
  end

  def update(conn, %{"id" => id, "restaurant" => restaurant_params}) do
    restaurant = Lunch.get_restaurant!(id)

    case Lunch.update_restaurant(restaurant, restaurant_params) do
      {:ok, restaurant} ->
        conn
        |> put_flash(:info, "Restaurant updated successfully.")
        |> redirect(to: restaurant_path(conn, :show, restaurant))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", restaurant: restaurant, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    restaurant = Lunch.get_restaurant!(id)
    {:ok, _restaurant} = Lunch.delete_restaurant(restaurant)

    conn
    |> put_flash(:info, "Restaurant deleted successfully.")
    |> redirect(to: restaurant_path(conn, :index))
  end
end
