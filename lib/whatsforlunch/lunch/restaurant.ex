defmodule Whatsforlunch.Lunch.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset


  schema "restaurants" do
    field :location, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :location])
    |> validate_required([:name, :location])
  end
end
