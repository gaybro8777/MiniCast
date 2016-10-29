defmodule Mix.Tasks.Crawler.Refresh do
  use Mix.Task
  import Mix.Ecto

  #use SuperTiger.Crawler.Itunes.Home

  @shortdoc "Start refresh podcast data"

  @moduledoc """
    Parse itunes data, update category, sub link. feed
  """

  def run(_args) do
    Mix.shell.info "Start procesing!"
    #ensure_repo(repo, _args)
    #ensure_started(Repo)

    #podcast = Repo.get(SuperTiger.Podcast, 1)
    #IO.puts podcast
    SuperTiger.Crawler.Itunes.Home.get_category
  end


  # We can define other functions as needed here.
end
