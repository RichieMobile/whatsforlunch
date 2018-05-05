defmodule Whatsforlunch.Yelp.YelpApiTest do
    use ExUnit.Case

    alias Whatsforlunch.Yelp.YelpApi
    alias Whatsforlunch.Yelp.SearchResult
    alias Whatsforlunch.Yelp.Restaurant
    alias Whatsforlunch.Yelp.Address

    describe "Yelp API" do
        test "Should return some restaurants when searching with valid address" do
            {status, search_result} = YelpApi.search("1600 Amphitheatre Parkway, Mountain View, CA")
            assert status == :ok
            assert length(search_result.businesses) > 0, 
                "Expected length > 40, but was #{length(search_result.businesses)}"

            restaurant = List.first(search_result.businesses)
            assert restaurant.name != "", "Restaurant name was empty"
            assert length(restaurant.location.display_address) > 0, "Restaurant location.display_address was empty"
            assert restaurant.url != "", "Restaurant website was empty"
        end
    end
end
