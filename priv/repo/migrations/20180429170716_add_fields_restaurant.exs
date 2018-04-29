defmodule Whatsforlunch.Repo.Migrations.AddFieldsRestaurant do
  use Ecto.Migration

  def change do
    alter table(:restaurants) do
      add :website, :string
    end
  end
end
