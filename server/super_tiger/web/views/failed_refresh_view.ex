defmodule SuperTiger.FailedRefreshView do
  use SuperTiger.Web, :view

  def render("index.json", %{fail_refreshes: fail_refreshes}) do
    %{data: render_many(fail_refreshes, SuperTiger.FailedRefreshView, "failed_refresh.json")}
  end

  def render("show.json", %{failed_refresh: failed_refresh}) do
    %{data: render_one(failed_refresh, SuperTiger.FailedRefreshView, "failed_refresh.json")}
  end

  def render("failed_refresh.json", %{failed_refresh: failed_refresh}) do
    %{id: failed_refresh.id,
      name: failed_refresh.name,
      url: failed_refresh.url}
  end
end
