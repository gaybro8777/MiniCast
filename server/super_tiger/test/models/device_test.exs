defmodule SuperTiger.DeviceTest do
  use SuperTiger.ModelCase

  alias SuperTiger.Device

  @valid_attrs %{platform: "some content", token: "some content", uuid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Device.changeset(%Device{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Device.changeset(%Device{}, @invalid_attrs)
    refute changeset.valid?
  end
end
