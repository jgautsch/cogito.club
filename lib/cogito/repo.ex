defmodule Cogito.Repo do
  use Ecto.Repo,
    otp_app: :cogito,
    adapter: Ecto.Adapters.Postgres
end
