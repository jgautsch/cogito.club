defmodule CogitoWeb.Router do
  use CogitoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  get "/ready", CogitoWeb.ReadyController, :show
  get "/health_check", CogitoWeb.HealthCheckController, :show

  scope "/graphql" do
    pipe_through :api

    forward "/api", Absinthe.Plug,
      schema: CogitoWeb.Schema,
      json_codec: Jason

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: CogitoWeb.Schema,
      socket: CogitoWeb.UserSocket,
      json_codec: Jason
  end

  scope "/api", CogitoWeb do
    pipe_through :api
  end
end
