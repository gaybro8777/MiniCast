defmodule SuperTiger.Episode do
  use SuperTiger.Web, :model

  schema "episodes" do
    field :url, :string
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:url, :name])
    |> validate_required([:url, :name])
  end
end
