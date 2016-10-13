defmodule SuperTiger.Device do
  use SuperTiger.Web, :model

  schema "devices" do
    field :platform, :string
    field :token, :string
    field :uuid, :string
    belongs_to :user, SuperTiger.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:platform, :token, :uuid])
    |> validate_required([:platform, :token, :uuid])
  end
end
