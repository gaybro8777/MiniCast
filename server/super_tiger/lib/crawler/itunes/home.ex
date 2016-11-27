defmodule SuperTiger.Crawler.Itunes.Home do
  use Mix.Task
  import Ecto.Query

  def prepare do
    HTTPoison.start
  end

  # Crawl podcast
  def get_podcast(repo) do
    prepare

    Mix.shell.info "Start crawl podcast"

    repo.all(SuperTiger.Category)
      |> Enum.each(fn(category) -> process_podcast(repo, category) end)
      #|> Enum.each(fn(category) -> spawn(fn -> process_podcast(repo, category) end) end)
  end

  # Crawl category
  def get_category(repo) do
    prepare

    Mix.shell.info "Start crawl category"
    task = Task.async(fn -> process_category(repo, "https://itunes.apple.com/us/genre/podcasts/id26?mt=2", "1") end)
    Task.await(task)
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

  def process_category(repo, url, parent_id) do
    get_url(url)
    |> Floki.find(selector(parent_id))
    |> Enum.map(fn(item) ->
      url = Floki.attribute(item, "href") |> List.first
      id =  Regex.named_captures(~r/\/id(?<id>\d+)\?/, url)

      category = %SuperTiger.Category{
        category_id: id["id"],
        name: Floki.text(item),
        url:  url,
        parent_id: parent_id
      }

    IO.inspect category
    check_existe_category = SuperTiger.Repo.one(from p in SuperTiger.Category, where: p.category_id == ^category.category_id and p.parent_id == ^category.parent_id, select: count("*"))

    if check_existe_category == 0 do #0 && category.category_id != category.parent_id do
      case SuperTiger.Repo.insert(category) do
        {:ok, inserted_post} ->
          Mix.shell.info "Inserted category"
          IO.inspect inserted_post
          Mix.shell.info "\n>>\n\n"
        _ ->
          Mix.shell.info "#{category[:name]} is existed"
      end
    end

    if parent_id == "1" do
      Task.async(fn() -> process_category(repo, url, category.category_id) end)
    end
    end)
    |> Enum.map(fn(t) -> if t do Task.await(t) end; end)
  end

  # Download podcast for category
  def process_podcast(repo, category) do
    IO.puts "Start finding podcast in #{category.name}"
    [
      "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O",
      "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "*"
    ]
    |> Enum.each(fn(letter) ->
      #spawn(__MODULE__, :process_podcast_with_letter, [repo, category, letter])
      process_podcast_with_letter(repo, category, letter)
    end)
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
            name: podcast[:name],
            category: category,
            source_id: podcast[:source_id],
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
    podcast_id =  Regex.named_captures(~r/\/id(?<id>\d+)\?/, url)
    name = Floki.text(item)
    %{:url => url, :name => name, :source_id => podcast_id[:id]}
    end)
  end

  defp create_podcast(podcast) do
    exist = SuperTiger.Repo.one(from p in SuperTiger.Podcast, where: p.url == ^podcast.url)
    if exist == nil do
      case SuperTiger.Repo.insert(podcast) do
        {:ok, inserted_post} ->
          Mix.shell.info "Inserted podcast"
          IO.inspect podcast
          IO.inspect inserted_post
          Mix.shell.info "\n>>\n\n"
        _ ->
          Mix.shell.info "#{podcast.name} is existed"
      end
    else
      Mix.shell.info "Update podcast #{podcast.url}"
      changeset = SuperTiger.Podcast.changeset(exist, %{
        :url => podcast.url,
        :name => podcast.name,
        :category => podcast.category,
        :source_id => podcast.source_id,
      })
      SuperTiger.Repo.update(changeset)
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
