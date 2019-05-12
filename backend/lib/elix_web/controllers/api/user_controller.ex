defmodule ElixWeb.Api.UserController do
  use ElixWeb, :controller

  alias Elix.Accounts

  def index(conn, _params) do
    users = Accounts.get_users()
    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "user.json", user: user)
  end

  def create(conn, args) do
    case Accounts.create_user(args) do
      {:error, changeset} ->
        {
          :error,
          message: "Could not create account",
          details: ChangesetErrors.error_details(changeset)
        }

      {:ok, user} ->
        token = ElixWeb.AuthToken.sign(user)
        render(conn, "signup.json", %{token: token, user: user})
    end
  end


end
