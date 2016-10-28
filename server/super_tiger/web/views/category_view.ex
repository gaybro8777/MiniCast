defmodule SuperTiger.CategoryView do
  use SuperTiger.Web, :view

  def render("index.json", %{categories: categories}) do
    %{data: render_many(categories, SuperTiger.CategoryView, "category.json")}
  end

  def render("show.json", %{category: category}) do
    %{data: render_one(category, SuperTiger.CategoryView, "category.json")}
  end

  def render("category.json", %{category: category}) do
    %{id: category.id,
      name: category.name,
      parent_id: category.parent_id}
  end
end
