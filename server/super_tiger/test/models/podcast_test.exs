defmodule SuperTiger.PodcastTest do
  use SuperTiger.ModelCase

  alias SuperTiger.Podcast

  @valid_attrs %{name: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Podcast.changeset(%Podcast{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Podcast.changeset(%Podcast{}, @invalid_attrs)
    refute changeset.valid?
  end
end
