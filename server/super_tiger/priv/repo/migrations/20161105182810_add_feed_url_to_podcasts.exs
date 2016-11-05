defmodule SuperTiger.Repo.Migrations.AddFeedUrlToPodcasts do
  use Ecto.Migration

  def change do
    alter table(:podcasts) do
      add :feed_uri, :string
    end
  end
end
