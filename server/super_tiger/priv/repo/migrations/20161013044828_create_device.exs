defmodule SuperTiger.Repo.Migrations.CreateDevice do
  use Ecto.Migration

  def change do
    create table(:devices) do
      add :platform, :string
      add :token, :string
      add :uuid, :string
      add :user_id, references(:users)

      timestamps()
    end

  end
end
