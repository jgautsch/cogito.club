defmodule Cogito.Repo.Migrations.EmptyMigrationForCi do
  use Ecto.Migration

  @moduledoc """
  CircleCI chokes when attempting to run migrations and there are none to run.
  So this is a no-op migration to make CircleCI happy.
  """

  def change do
    # no op
  end
end
