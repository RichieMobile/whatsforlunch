defmodule Whatsforlunch.Mapper.SearchResultToRestaurantTest do
    use ExUnit.Case
    alias Whatsforlunch.Mapper.SearchResultToRestaurant
    alias Whatsforlunch.Yelp.SearchResult
    alias Whatsforlunch.Yelp.Address
    alias Whatsforlunch.Yelp.Restaurant, as: YR
    alias Whatsforlunch.Lunch.Restaurant, as: LR

    describe "SearchResultToMapper" do
        test "Should map a Yelp.SearchResult to a list of Lunch.Restaurant" do
            search_result = create_search_result()
            restaurants = SearchResultToRestaurant.map(search_result)

            assert length(restaurants) == 2, "Expected restaurants length == 2, but was #{length(restaurants)}"

            r1 = List.first restaurants
            assert r1.name == "name1"
            assert r1.website == "url1"
            assert r1.location == "first1, second1"

            r1 = Enum.at(restaurants, 1)
            assert r1.name == "name2"
            assert r1.website == "url2"
            assert r1.location == "first2, second2"
        end

        defp create_search_result() do
            r1 = %YR{
                name: "name1", 
                url: "url1", 
                location: %Address{
                    display_address: ["first1", "second1"]
                }
            }
            r2 = %YR{
                name: "name2", 
                url: "url2", 
                location: %Address{
                    display_address: ["first2", "second2"]
                }
            }
            search_result = %SearchResult{businesses: [r1, r2]}
        end
    end
end
