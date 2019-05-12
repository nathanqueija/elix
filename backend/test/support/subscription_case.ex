defmodule ElixWeb.SubscriptionCase do
  @moduledoc """
  This module defines the test case to be used by
  subscription tests.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      # Import conveniences for testing with channels
      use Phoenix.ConnTest

      use ElixWeb.ChannelCase
      use Absinthe.Phoenix.SubscriptionTest,
        schema: ElixWeb.Schema.Schema
      import Elix.TestHelpers

      defp auth_user(conn, user) do
        token = ElixWeb.AuthToken.sign(user)
        put_req_header(conn, "authorization", "Bearer #{token}")
      end

      setup do
        places_fixture()

        {:ok, socket} =
            Phoenix.ChannelTest.connect(ElixWeb.UserSocket, %{})
        {:ok, socket} =
            Absinthe.Phoenix.SubscriptionTest.join_absinthe(socket)

        {:ok, socket: socket}
      end
    end
  end
end
