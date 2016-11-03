defmodule SuperTiger.Repo.Migrations.CreatePodcast do
  use Ecto.Migration

  def change do
    create table(:podcasts) do
      add :url, :string
      add :name, :string

      timestamps()
    end

    create_index(:podcasts, [:name])
    create_index(:podcasts, [:url])
  end
end
