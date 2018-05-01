defmodule Whatsforlunch.Yelp.Address do
    @derive [Poison.Encoder]
    defstruct [:display_address]
end