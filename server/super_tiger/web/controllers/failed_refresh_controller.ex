defmodule SuperTiger.FailedRefreshController do
  use SuperTiger.Web, :controller

  alias SuperTiger.FailedRefresh

  def index(conn, _params) do
    fail_refreshes = Repo.all(FailedRefresh)
    render(conn, "index.json", fail_refreshes: fail_refreshes)
  end

  def create(conn, %{"failed_refresh" => failed_refresh_params}) do
    changeset = FailedRefresh.changeset(%FailedRefresh{}, failed_refresh_params)

    case Repo.insert(changeset) do
      {:ok, failed_refresh} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", failed_refresh_path(conn, :show, failed_refresh))
        |> render("show.json", failed_refresh: failed_refresh)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SuperTiger.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    failed_refresh = Repo.get!(FailedRefresh, id)
    render(conn, "show.json", failed_refresh: failed_refresh)
  end

  def update(conn, %{"id" => id, "failed_refresh" => failed_refresh_params}) do
    failed_refresh = Repo.get!(FailedRefresh, id)
    changeset = FailedRefresh.changeset(failed_refresh, failed_refresh_params)

    case Repo.update(changeset) do
      {:ok, failed_refresh} ->
        render(conn, "show.json", failed_refresh: failed_refresh)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(SuperTiger.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    failed_refresh = Repo.get!(FailedRefresh, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(failed_refresh)

    send_resp(conn, :no_content, "")
  end
end
