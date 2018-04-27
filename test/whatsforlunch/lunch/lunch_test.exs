defmodule Whatsforlunch.LunchTest do
  use Whatsforlunch.DataCase

  alias Whatsforlunch.Lunch

  describe "restaurants" do
    alias Whatsforlunch.Lunch.Restaurant

    @valid_attrs %{location: "some location", name: "some name"}
    @update_attrs %{location: "some updated location", name: "some updated name"}
    @invalid_attrs %{location: nil, name: nil}

    def restaurant_fixture(attrs \\ %{}) do
      {:ok, restaurant} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Lunch.create_restaurant()

      restaurant
    end

    test "list_restaurants/0 returns all restaurants" do
      restaurant = restaurant_fixture()
      assert Lunch.list_restaurants() == [restaurant]
    end

    test "get_restaurant!/1 returns the restaurant with given id" do
      restaurant = restaurant_fixture()
      assert Lunch.get_restaurant!(restaurant.id) == restaurant
    end

    test "create_restaurant/1 with valid data creates a restaurant" do
      assert {:ok, %Restaurant{} = restaurant} = Lunch.create_restaurant(@valid_attrs)
      assert restaurant.location == "some location"
      assert restaurant.name == "some name"
    end

    test "create_restaurant/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Lunch.create_restaurant(@invalid_attrs)
    end

    test "update_restaurant/2 with valid data updates the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, restaurant} = Lunch.update_restaurant(restaurant, @update_attrs)
      assert %Restaurant{} = restaurant
      assert restaurant.location == "some updated location"
      assert restaurant.name == "some updated name"
    end

    test "update_restaurant/2 with invalid data returns error changeset" do
      restaurant = restaurant_fixture()
      assert {:error, %Ecto.Changeset{}} = Lunch.update_restaurant(restaurant, @invalid_attrs)
      assert restaurant == Lunch.get_restaurant!(restaurant.id)
    end

    test "delete_restaurant/1 deletes the restaurant" do
      restaurant = restaurant_fixture()
      assert {:ok, %Restaurant{}} = Lunch.delete_restaurant(restaurant)
      assert_raise Ecto.NoResultsError, fn -> Lunch.get_restaurant!(restaurant.id) end
    end

    test "change_restaurant/1 returns a restaurant changeset" do
      restaurant = restaurant_fixture()
      assert %Ecto.Changeset{} = Lunch.change_restaurant(restaurant)
    end
  end
end
