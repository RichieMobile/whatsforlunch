defmodule Whatsforlunch.Lunch.Restaurant do
  use Ecto.Schema
  import Ecto.Changeset


  schema "restaurants" do
    field :location, :string
    field :name, :string
    field :website, :string

    timestamps()
  end

  @doc false
  def changeset(restaurant, attrs) do
    restaurant
    |> cast(attrs, [:name, :location, :website])
    |> validate_required([:name])
  end
end
