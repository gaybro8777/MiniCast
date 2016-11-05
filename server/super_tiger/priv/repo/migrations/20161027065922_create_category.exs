defmodule SuperTiger.Repo.Migrations.CreateCategory do
  use Ecto.Migration

  def change do
    create table(:categories) do
      add :name, :string
      add :parent_id, :string
      add :category_id, :string
      add :url, :string

      timestamps()
    end

  end
end
