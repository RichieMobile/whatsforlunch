defmodule Whatsforlunch.Yelp.YelpApi do
    alias Whatsforlunch.Yelp.Restaurant
    alias Whatsforlunch.Yelp.Address
    alias Whatsforlunch.Yelp.SearchResult

    require Logger

    @moduledoc """
    This module is used for accessing Yelp API's.
    """

    @doc """
    Searches Yelp for restaurants based on a location (generally an address).
    ## Parameters

        - location: String that represents a location (address, zip code, etc..)

    ## Examples

        iex> Whatsforlunch.Yelp.YelpApi.search("1600 Amphitheatre Parkway, Mountain View, CA")
        [info] Searching for restaurants with location: 1600 Amphitheatre Parkway, Mountain View, CA
        {:ok,
        %Whatsforlunch.Yelp.SearchResult{
        businesses: [
            %Whatsforlunch.Yelp.Restaurant{
            location: %Whatsforlunch.Yelp.Address{
                display_address: ["..."]
            },
            name: "...",
            url: "https://www.yelp.com/..."
            },
            ...
        ]
        }}
    """
    def search(location) do
        key = Application.get_env(:whatsforlunch, Whatsforlunch.Yelp.YelpApi)[:yelp_api_key]
        Logger.info("Yelp API Key: #{key}")
        Logger.info("Searching for restaurants with location: #{location}")

        url = "https://api.yelp.com/v3/businesses/search"
        headers = ["Authorization": "Bearer #{key}", "Accept": "Application/json; Charset=utf-8"]
        params = %{term: "food", location: location, limit: 40}
        options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 5000]
        case HTTPoison.get(url, headers, params: params, options: options) do
            {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
                {:ok, decode_response(body)}
            {:ok, %HTTPoison.Response{status_code: 404}} ->
                {:error, "404 Not Found"}
            {:ok, %HTTPoison.Response{status_code: 401}} ->
                {:error, "Unauthorized"}
            {:error, %HTTPoison.Error{reason: reason}} ->
                {:error, reason}
        end
    end

    defp decode_response(response) do
        response
        |> Poison.decode!(as: %SearchResult{businesses: [%Restaurant{location: %Address{}}]})
    end
end