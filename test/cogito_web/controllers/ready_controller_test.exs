defmodule CogitoWeb.ReadyControllerTest do
  use CogitoWeb.ConnCase, async: true

  test "GET /ready returns `200 ready`", %{conn: conn} do
    body =
      conn
      |> get("/ready")
      |> response(200)

    assert body == "ready"
  end
end
