defmodule SuperTiger.FailedRefreshControllerTest do
  use SuperTiger.ConnCase

  alias SuperTiger.FailedRefresh
  @valid_attrs %{name: "some content", url: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, failed_refresh_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    failed_refresh = Repo.insert! %FailedRefresh{}
    conn = get conn, failed_refresh_path(conn, :show, failed_refresh)
    assert json_response(conn, 200)["data"] == %{"id" => failed_refresh.id,
      "name" => failed_refresh.name,
      "url" => failed_refresh.url}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, failed_refresh_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, failed_refresh_path(conn, :create), failed_refresh: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(FailedRefresh, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, failed_refresh_path(conn, :create), failed_refresh: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    failed_refresh = Repo.insert! %FailedRefresh{}
    conn = put conn, failed_refresh_path(conn, :update, failed_refresh), failed_refresh: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(FailedRefresh, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    failed_refresh = Repo.insert! %FailedRefresh{}
    conn = put conn, failed_refresh_path(conn, :update, failed_refresh), failed_refresh: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    failed_refresh = Repo.insert! %FailedRefresh{}
    conn = delete conn, failed_refresh_path(conn, :delete, failed_refresh)
    assert response(conn, 204)
    refute Repo.get(FailedRefresh, failed_refresh.id)
  end
end
