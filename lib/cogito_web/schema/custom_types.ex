defmodule CogitoWeb.Schema.CustomTypes do
  use Absinthe.Schema.Notation

  scalar :uuid4, name: "UUID4" do
    description """
    The `UUID4` scalar type represents UUID4 compliant string data, represented
    as UTF-8 character sequences. The UUID4 type is most often used to represent
    unique human-readable ID strings.
    """

    serialize &encode_uuid/1
    parse &decode_uuid/1
  end

  defp encode_uuid(value), do: value

  @spec decode_uuid(Absinthe.Blueprint.Input.String.t()) :: {:ok, term()} | :error
  @spec decode_uuid(Absinthe.Blueprint.Input.Null.t()) :: {:ok, nil}
  defp decode_uuid(%Absinthe.Blueprint.Input.String{value: value}) do
    Ecto.UUID.cast(value)
  end

  defp decode_uuid(%Absinthe.Blueprint.Input.Null{}) do
    {:ok, nil}
  end

  defp decode_uuid(_) do
    :error
  end
end
