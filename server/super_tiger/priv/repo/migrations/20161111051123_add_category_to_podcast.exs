defmodule SuperTiger.Repo.Migrations.AddCategoryToPodcast do
  use Ecto.Migration

  def change do
    alter table(:podcasts) do
      add :category_id, :integer
    end
  end
end
