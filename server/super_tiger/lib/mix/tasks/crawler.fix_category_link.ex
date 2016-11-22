defmodule Mix.Tasks.Crawler.FixCategory do
  use Mix.Task
  import Mix.Ecto

  #use SuperTiger.Crawler.Itunes.Home

  @shortdoc "One off task to fix category link"

  @moduledoc """
  Correct missing category link
  """

  def run(args) do
    Mix.shell.info "Start procesing!"
    repos = parse_repo(args)

    Enum.each repos, fn repo ->
      ensure_repo(repo, args)
      ensure_started(repo, [{:pool_size, 10}])

      #SuperTiger.Crawler.Itunes.Home.get_category(repo)
      SuperTiger.Crawler.Itunes.Home.get_podcast(repo)
    end
  end


  # We can define other functions as needed here.
end
