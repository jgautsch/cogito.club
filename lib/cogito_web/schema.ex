defmodule CogitoWeb.Schema do
  use Absinthe.Schema

  # alias CogitoWeb.Resolvers
  alias CogitoWeb.Schema.Middleware

  def middleware(middleware, field, object) do
    middleware
    |> apply(:errors, field, object)
    |> apply(:debug, field, object)
  end

  defp apply(middleware, :errors, _field, %{identifier: :mutation}) do
    middleware ++ [Middleware.ChangesetErrors]
  end

  defp apply(middleware, :debug, _field, _object) do
    if System.get_env("DEBUG") do
      [{Middleware.Debug, :start}] ++ middleware
    else
      middleware
    end
  end

  defp apply(middleware, _, _, _) do
    middleware
  end

  import_types __MODULE__.CustomTypes

  query do
    # PUBLIC
    field :ping, :string do
      resolve(fn _, _, _ -> {:ok, "pong"} end)
    end
  end
end
