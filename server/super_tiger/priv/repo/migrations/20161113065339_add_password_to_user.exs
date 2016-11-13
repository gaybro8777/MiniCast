defmodule SuperTiger.Repo.Migrations.AddPasswordToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :password_hash, :string
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:name])
  end
end
