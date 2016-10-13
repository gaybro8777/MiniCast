defmodule SuperTiger.PodcastView do
  use SuperTiger.Web, :view

  def render("index.json", %{podcasts: podcasts}) do
    %{data: render_many(podcasts, SuperTiger.PodcastView, "podcast.json")}
  end

  def render("show.json", %{podcast: podcast}) do
    %{data: render_one(podcast, SuperTiger.PodcastView, "podcast.json")}
  end

  def render("podcast.json", %{podcast: podcast}) do
    %{id: podcast.id,
      url: podcast.url,
      name: podcast.name}
  end
end
