defmodule Whatsforlunch.Yelp.YelpApiTest do
    use ExUnit.Case

    alias Whatsforlunch.Yelp.YelpApi
    alias Whatsforlunch.Yelp.SearchResult
    alias Whatsforlunch.Yelp.Restaurant
    alias Whatsforlunch.Yelp.Address

    test "Yelp API returns some restaurants" do
        {_, search_result} = YelpApi.search("700 E Franklin St, Richmond, VA 23219")
        restaurants = search_result.businesses
        Enum.each restaurants, fn r ->
            IO.inspect r.location.display_address
        end
        assert elem(YelpApi.search("700 E Franklin St, Richmond, VA 23219"), 0) == :ok
    end
end
