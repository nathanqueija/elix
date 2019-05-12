defmodule GetawaysWeb.Api.UserController do
  use GetawaysWeb, :controller

  alias Getaways.Accounts

  def index(conn, _params) do
    users = Accounts.get_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "user.json", user: user)
  end


end