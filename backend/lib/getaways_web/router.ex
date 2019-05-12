defmodule GetawaysWeb.Router do
  use GetawaysWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :graphql do
    plug :accepts, ["json"]
    plug GetawaysWeb.Plugs.SetCurrentUser
  end


   # REST api specifics
  scope "/", GetawaysWeb.Api do
    pipe_through :api

    get "/users", UserController, :index
    get "/users/:id", UserController, :show




    get "/", PlacesController, :index
    get "/:slug", PlacesController, :place
  end





  # GRAPHQL specifics
  scope "/graphql" do
    pipe_through :graphql

    forward "/api", Absinthe.Plug,
      schema: GetawaysWeb.Schema.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: GetawaysWeb.Schema.Schema,
      socket: GetawaysWeb.UserSocket,
      interface: :simple
    end
end
