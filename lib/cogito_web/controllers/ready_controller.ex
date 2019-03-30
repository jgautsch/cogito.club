defmodule CogitoWeb.ReadyController do
  use CogitoWeb, :controller

  def show(conn, _) do
    send_resp(conn, 200, "ready")
  end
end
