defmodule CogitoWeb.HealthCheckController do
  use CogitoWeb, :controller

  def show(conn, _) do
    send_resp(conn, 200, "healthy")
  end
end
