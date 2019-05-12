defmodule GetawaysWeb.Api.PlacesView do
  use GetawaysWeb, :view

  def render("index.json", %{places: places}) do
    %{data: render_many(places, __MODULE__, "place.json", as: :place)}
  end

  def render("place.json", %{place: place} ) do
    %{
      id: place.id,
      name: place.name,
      description: place.description
    }
  end
end