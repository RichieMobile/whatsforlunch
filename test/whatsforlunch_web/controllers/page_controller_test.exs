defmodule WhatsforlunchWeb.PageControllerTest do
  use WhatsforlunchWeb.ConnCase
  alias Whatsforlunch.Lunch

  @create_attrs %{location: "some location", name: "some name", website: "http://website"}

  def fixture(:restaurant) do
    {:ok, restaurant} = Lunch.create_restaurant(@create_attrs)
    restaurant
  end

  describe "index" do
    test "GET /", %{conn: conn} do
      conn = get conn, "/"
      assert html_response(conn, 200) =~ "Welcome to What's for Lunch!"
    end
  end

  describe "What's for lunch?" do
    test "renders a back button", %{conn: conn} do
      conn = get conn, page_path(conn, :random)
      assert html_response(conn, 200) =~ "Back"
    end

    test "renders 'Oops' page when no restaurants are configured", %{conn: conn} do
      conn = get conn, page_path(conn, :random)
      assert html_response(conn, 200) =~ "Oops!"
    end

    test "renders a restaurant", %{conn: conn} do
      fixture(:restaurant)

      conn = get conn, page_path(conn, :random)
      response = html_response(conn, 200)
      assert response =~ "some location"
      assert response =~ "some name"
      assert response =~ "http://website"
    end
  end
end