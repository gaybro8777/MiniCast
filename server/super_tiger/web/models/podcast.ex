defmodule SuperTiger.Podcast do
  use SuperTiger.Web, :model

  schema "podcasts" do
    field :url, :string
    field :name, :string
    field :feed_uri, :string
    field :source_id, :string
    belongs_to :category, SuperTiger.Category

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :name, :feed_uri])
    |> validate_required([:url, :name, :feed_uri])
  end
end
