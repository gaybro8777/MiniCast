defmodule SuperTiger.PodcastController do
  use SuperTiger.Web, :controller

  alias SuperTiger.Podcast

  def index(conn, _params) do
    podcasts = Repo.all(Podcast)
    render(conn, "index.json", podcasts: podcasts)
  end

  def create(conn, %{"podcast" => podcast_params}) do
    changeset = Podcast.changeset(%Podcast{}, podcast_params)

    case Repo.insert(changeset) do
      {:ok, podcast} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", podcast_path(conn, :show, podcast))
        |> render("show.json", podcast: podcast)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SuperTiger.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    podcast = Repo.get!(Podcast, id)
    render(conn, "show.json", podcast: podcast)
  end

  def update(conn, %{"id" => id, "podcast" => podcast_params}) do
    podcast = Repo.get!(Podcast, id)
    changeset = Podcast.changeset(podcast, podcast_params)

    case Repo.update(changeset) do
      {:ok, podcast} ->
        render(conn, "show.json", podcast: podcast)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SuperTiger.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    podcast = Repo.get!(Podcast, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(podcast)

    send_resp(conn, :no_content, "")
  end
end
