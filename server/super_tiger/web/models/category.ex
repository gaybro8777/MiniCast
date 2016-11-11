defmodule SuperTiger.Category do
  use SuperTiger.Web, :model

  schema "categories" do
    field :name, :string
    field :parent_id, :string
    field :category_id, :string
    field :url, :string
    has_many :podcasts, SuperTiger.Podcast

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :parent_id])
    |> validate_required([:name, :parent_id])
  end
end
