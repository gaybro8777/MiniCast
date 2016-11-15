defmodule SuperTiger.Session do
  use SuperTiger.Web, :model

  schema "sessions" do
    field :token, :string
    belongs_to :user, SuperTiger.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:token])
    |> validate_required([:token])
  end
end
