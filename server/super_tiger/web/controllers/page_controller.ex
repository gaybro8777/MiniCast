defmodule SuperTiger.PageController do
  use SuperTiger.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
