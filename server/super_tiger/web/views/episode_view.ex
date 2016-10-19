defmodule SuperTiger.EpisodeView do
  use SuperTiger.Web, :view

  def render("index.json", %{episodes: episodes}) do
    %{data: render_many(episodes, SuperTiger.EpisodeView, "episode.json")}
  end

  def render("show.json", %{episode: episode}) do
    %{data: render_one(episode, SuperTiger.EpisodeView, "episode.json")}
  end

  def render("episode.json", %{episode: episode}) do
    %{id: episode.id,
      url: episode.url,
      name: episode.name}
  end
end
