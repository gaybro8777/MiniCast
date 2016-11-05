defmodule SuperTiger.Repo.Migrations.CreateFailedRefresh do
  use Ecto.Migration

  def change do
    create table(:fail_refreshes) do
      add :name, :string
      add :url, :string

      timestamps()
    end

    create index(:fail_refreshes, [:name, :url])
  end
end
