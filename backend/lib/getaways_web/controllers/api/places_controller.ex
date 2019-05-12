defmodule GetawaysWeb.Api.PlacesController do
  use GetawaysWeb, :controller
  alias Getaways.Vacation

  def index(conn, _params) do
    places = Vacation.list_places()
    render(conn, "index.json", places: places)
  end

  def place(conn, %{"slug" => slug}) do
    place = Vacation.get_place_by_slug!(slug)
    render(conn, "place.json", place: place)
  end
end