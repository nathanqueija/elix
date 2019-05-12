defmodule GetawaysWeb.Api.UserView do
  use GetawaysWeb, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, __MODULE__, "user.json")}
  end

  def render("user.json", %{user: user} ) do
    %{
      id: user.id,
      email: user.email,
      username: user.username
    }
  end
end