defmodule SuperTiger.Crawler.Itunes.Home do
  def get_category do
    HTTPoison.start

    IO.puts "Get index"
    case HTTPoison.get "https://itunes.apple.com/us/genre/podcasts/id26?mt=2" do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        process_sitemap(body)
      _ ->
        IO.puts "Unexpected error"
    end
  end

  def process_sitemap(body) do
    body
    |> Floki.find("#genre-nav .top-level-genre")
    |> Enum.map(fn(item) ->
        url = Floki.attribute(item, "href") |> List.first
        id =  Regex.named_captures(~r/\/id(?<id>\d+)\?/, url)

        category = %{
          :id => id["id"],
          :name => Floki.text(item),
          :url  => url,
        }

        IO.inspect category

        end)
  end
end
