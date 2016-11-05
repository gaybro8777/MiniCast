defmodule SuperTiger.Crawler.Itunes.Episode do
  use Mix.Task
  import Ecto.Query

  defmodule ItunePodcast do
    @derive [Poison.Encoder]
    defstruct [:resultCount, :results]
  end

  def prepare do
    HTTPoison.start
  end

  # Crawl podcast
  def get_feed(repo) do
    prepare

    Mix.shell.info "Start crawl podcast's feed"

    repo.all(SuperTiger.Podcast)
      |> Enum.each(fn(podcast) -> process_podcast_feed(repo, podcast) end)
  end

  def get_url(url, attempt \\ 1) do
    case HTTPoison.get url do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      error ->
        if attempt == 3 do
          raise {:error, url, error}
        else
          IO.puts "Fail to get url. Retry: Attempt #{attempt+1}"
          get_url(url, attempt + 1)
        end
    end
  end

  # Download podcast for category
  def process_podcast_feed(repo, podcast) do
    case String.split(podcast.url, "/id") do
      [_, itune_id] ->
        IO.puts "Start finding feedurl for #{itune_id}"

        itune_data = get_url("https://itunes.apple.com/lookup?id=#{itune_id}")
        itune_podcast = Poison.Parser.parse!(itune_data)
        feed_url = List.first(itune_podcast["results"])["feedUrl"]
        IO.puts feed_url
        changeset = SuperTiger.Podcast.changeset(podcast, %{"feed_uri" => feed_url})
        case SuperTiger.Repo.update(changeset) do
          {:ok, p} ->
            IO.puts "Update feed_uri for #{itune_id}. URL= #{feed_url}"
          {:error, p } ->
            IO.puts "Error"
        end
      _ ->
        IO.puts "Invalid #{podcast.url}"
    end
  end



  def process_podcast_with_letter(repo, category, letter) do
    IO.puts "Start finding podcast in #{category.name}, letter: #{letter}"
    try do
      get_url("#{category.url}&letter=#{letter}")
      |>find_page_link
      |> Enum.map(fn(page) ->
      IO.puts "Found page: #{page}"
      find_podcast_on_page("#{category.url}&letter=#{letter}&page=#{page}")
        |> Enum.map(fn(podcast) ->
          create_podcast(%SuperTiger.Podcast{
            url: podcast[:url],
            name: podcast[:name]
          })
        end)
      end)
    rescue
      e in RuntimeError -> SuperTiger.Repo.insert(%SuperTiger.FailedRefresh{
                            name: "podcast",
                            url:  elem(e, 1)
                            })
    end
  end


  def find_page_link(body) do
    # TODO Find a way to support .not selectpr
    body
    |> Floki.find(".paginate a")
    |> Enum.filter(fn(item) -> Floki.attribute(item, "class") != ["paginate-more"] end)
                                                                  |> Enum.map(fn(item) -> Floki.text(item) end)
  end

  def find_podcast_on_page(url) do
    get_url(url)
    |> Floki.find("#selectedcontent a")
    |> Enum.map(fn(item) ->
    url = Floki.attribute(item, "href") |> List.first
    #podcast_id =  Regex.named_captures(~r/\/id(?<id>\d+)\?/, url)
    name = Floki.text(item)
    %{:url => url, :name => name}
    end)
  end

  defp create_podcast(podcast) do
    exist = SuperTiger.Repo.one(from p in SuperTiger.Podcast, where: p.url == ^podcast.url, select: count("*"))
    if exist == 0 do
      case SuperTiger.Repo.insert(podcast) do
        {:ok, inserted_post} ->
          Mix.shell.info "Inserted podcast"
          IO.inspect podcast
          IO.inspect inserted_post
          Mix.shell.info "\n>>\n\n"
        _ ->
          Mix.shell.info "#{podcast.name} is existed"
      end
    end
  end

  defp selector(id) do
    case id do
      "1" ->
        "#genre-nav .top-level-genre"
      _ ->
        ".top-level-subgenres a"
    end
  end
end
