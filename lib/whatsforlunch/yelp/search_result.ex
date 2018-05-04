defmodule Whatsforlunch.Yelp.SearchResult do
    @derive [Poison.Encoder]
    defstruct [:businesses]
end