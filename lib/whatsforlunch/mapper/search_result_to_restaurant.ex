defmodule Whatsforlunch.Mapper.SearchResultToRestaurant do
    alias Whatsforlunch.Lunch.Restaurant

    def map([]), do: []
    def map(search_result) do
        search_result.businesses
        |> Enum.filter(&(String.strip(&1.name) != ""))
        |> Enum.map(fn(x) -> 
            location = Enum.reduce(x.location.display_address, "", &(&2 <> &1))
            %{
                name: x.name,
                location: location,
                website: x.url
            }
            end)
    end
end