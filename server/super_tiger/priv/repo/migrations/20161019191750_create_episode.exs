defmodule SuperTiger.Repo.Migrations.CreateEpisode do
  use Ecto.Migration

  def change do
    create table(:episodes) do
      add :url, :string
      add :name, :string

      timestamps()
    end

  end
end
