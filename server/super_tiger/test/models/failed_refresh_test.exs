defmodule SuperTiger.FailedRefreshTest do
  use SuperTiger.ModelCase

  alias SuperTiger.FailedRefresh

  @valid_attrs %{name: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = FailedRefresh.changeset(%FailedRefresh{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = FailedRefresh.changeset(%FailedRefresh{}, @invalid_attrs)
    refute changeset.valid?
  end
end
