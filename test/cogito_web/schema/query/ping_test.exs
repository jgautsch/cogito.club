defmodule CogitoWeb.Schema.Query.PingTest do
  use CogitoWeb.ConnCase

  @query """
  query PingQuery {
    ping
  }
  """
  test "graphql ping query", %{conn: conn} do
    body =
      conn
      |> post("/graphql/api", query: @query)
      |> json_response(200)

    assert body == %{
             "data" => %{
               "ping" => "pong"
             }
           }
  end
end
