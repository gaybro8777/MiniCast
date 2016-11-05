defmodule Mix.Tasks.Crawler.Podcast do
  use Mix.Task
  import Mix.Ecto

  #use SuperTiger.Crawler.Itunes.Home

  @shortdoc "Start refresh podcast episode"

  @moduledoc """
  Parse itunes data, update category, sub link. feed
  """

  def run(args) do
    Mix.shell.info "Start procesing!"
    repos = parse_repo(args)

    Enum.each repos, fn repo ->
      ensure_repo(repo, args)
      ensure_started(repo, [{:pool_size, 10}])

      SuperTiger.Crawler.Itunes.Episode.get_feed(repo)
    end
  end

  # We can define other functions as needed here.
end
