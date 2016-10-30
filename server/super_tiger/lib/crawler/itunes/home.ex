defmodule SuperTiger.Crawler.Itunes.Home do
  use Mix.Task
  import Ecto.Query

  def prepare do
    HTTPoison.start
  end

  def get_podcast do
    prepare

    Mix.shell.info "Start crawl podcast"
  end

  def get_category(repo) do
    prepare

    Mix.shell.info "Start crawl category"
    task = Task.async(fn -> process_category(repo, "https://itunes.apple.com/us/genre/podcasts/id26?mt=2", "1") end)
    Task.await(task)
  end

  def get_url(url) do
    case HTTPoison.get url do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
      _ ->
        raise "Fail to get url #{:url}. Unexpected error"
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
end
