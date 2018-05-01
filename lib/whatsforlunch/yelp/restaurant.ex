defmodule Whatsforlunch.Yelp.Restaurant do
    @derive [Poison.Encoder]
    defstruct [:name,:url, :location]
end