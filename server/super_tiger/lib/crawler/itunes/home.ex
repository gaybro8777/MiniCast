defmodule SuperTiger.Crawler.Itunes.Home do
  def get_category do
    HTTPoison.start
    task = Task.async(fn -> process_category("https://itunes.apple.com/us/genre/podcasts/id26?mt=2", 1) end)
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

  def process_category(url, parent_id) do
    get_url(url)
    |> Floki.find("#genre-nav .top-level-genre")
    |> Enum.map(fn(item) ->
        url = Floki.attribute(item, "href") |> List.first
        id =  Regex.named_captures(~r/\/id(?<id>\d+)\?/, url)

        category = %{
          :id => id["id"],
          :name => Floki.text(item),
          :url  => url,
          :parent_id => parent_id
        }

        IO.inspect category
        Task.async(fn() ->
          process_category(url, category[:id])
        end)
      end)
    |> Enum.map(fn(t) -> IO.inspect t; Task.await(t) end)
  end
end
