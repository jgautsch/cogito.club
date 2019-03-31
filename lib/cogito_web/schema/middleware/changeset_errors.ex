defmodule CogitoWeb.Schema.Middleware.ChangesetErrors do
  @behaviour Absinthe.Middleware

  def call(res, _) do
    with %{errors: [%Ecto.Changeset{} = changeset]} <- res do
      %{res | value: %{errors: transform_errors(changeset)}, errors: []}
    end
  end

  defp transform_errors(changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(&format_error/1)
    |> Enum.map(fn
      # Case where error is on a nested/associated changeset
      {key, %{} = value} ->
        flatten_nested_error(key, value)

      {key, value} ->
        %{key: key, message: value}
    end)
    |> List.flatten()
  end

  defp format_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end

  defp flatten_nested_error(parent_key, %{} = errors) do
    Enum.map(errors, fn {key, value} ->
      %{key: "#{to_string(parent_key)}.#{key}", message: value}
    end)
  end
end
