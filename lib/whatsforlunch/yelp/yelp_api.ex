defmodule Whatsforlunch.Yelp.YelpApi do
    alias Whatsforlunch.Yelp.Restaurant
    alias Whatsforlunch.Yelp.Address
    alias Whatsforlunch.Yelp.SearchResult

    require Logger

    def search(location) do
        key = Application.get_env(:whatsforlunch, Whatsforlunch.Yelp.YelpApi)[:yelp_api_key]
        Logger.info("Yelp API Key: #{key}")
        Logger.info("Searching for restaurants with location: #{location}")

        url = "https://api.yelp.com/v3/businesses/search"
        headers = ["Authorization": "Bearer #{key}", "Accept": "Application/json; Charset=utf-8"]
        options = [ssl: [{:versions, [:'tlsv1.2']}], recv_timeout: 5000]
        case HTTPoison.get(url, headers, params: %{term: "food", location: location, limit: 40}, options: options) do
            {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
                Logger.info("body" <> body)
                {:ok, decode_response(body)}
            {:ok, %HTTPoison.Response{status_code: 404}} ->
                {:error, "404 Not Found"}
            {:ok, %HTTPoison.Response{status_code: 401}} ->
                {:error, "Unauthorized"}
            {:error, %HTTPoison.Error{reason: reason}} ->
                {:error, reason}
        end
    end

    def decode_response(response) do
        response
        |> Poison.decode!(as: %SearchResult{businesses: [%Restaurant{location: %Address{}}]})
    end
end