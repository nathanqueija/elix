defmodule ElixWeb.Router do
  use ElixWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug :accepts, ["json"]
    plug ElixWeb.Plugs.SetCurrentUser
  end


   # REST api specifics
  scope "/", ElixWeb.Api do
    pipe_through :api

    resources "/users", UserController, only: [:index, :show, :create]




    get "/", PlacesController, :index
    get "/:slug", PlacesController, :place
  end





  # GRAPHQL specifics
  scope "/graphql" do
    pipe_through :graphql

    forward "/api", Absinthe.Plug,
      schema: ElixWeb.Schema.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: ElixWeb.Schema.Schema,
      socket: ElixWeb.UserSocket,
      interface: :simple
    end
end
