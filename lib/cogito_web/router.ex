defmodule CogitoWeb.Router do
  use CogitoWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", CogitoWeb do
    pipe_through :api
  end
end
