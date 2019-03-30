defmodule CogitoWeb.Router do
  use CogitoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  get "/ready", CogitoWeb.ReadyController, :show
  get "/health_check", CogitoWeb.HealthCheckController, :show

  scope "/api", CogitoWeb do
    pipe_through :api
  end
end
