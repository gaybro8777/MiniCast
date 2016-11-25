defmodule SuperTiger.Repo.Migrations.AddPodcastIdToPodcast do
  use Ecto.Migration

  def change do
    alter table(:podcasts) do
      add :source_id, :string
    end

    create index(:podcasts, [:source_id])
  end
end
