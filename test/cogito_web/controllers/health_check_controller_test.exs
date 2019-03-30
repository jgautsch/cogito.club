defmodule CogitoWeb.HealthCheckControllerTest do
  use CogitoWeb.ConnCase, async: true

  test "GET /health_check returns `200 healthy`", %{conn: conn} do
    body =
      conn
      |> get("/health_check")
      |> response(200)

    assert body == "healthy"
  end
end
