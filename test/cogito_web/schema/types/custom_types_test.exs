defmodule CogitoWeb.Schema.CustomTypesTest do
  use ExUnit.Case, async: true

  alias CogitoWeb.Schema
  alias Absinthe.Type
  alias Absinthe.Blueprint.Input

  defmodule TestSchema do
    use Absinthe.Schema
    import_types Schema.CustomTypes

    query do
    end
  end

  defp serialize(type, value) do
    TestSchema.__absinthe_type__(type)
    |> Type.Scalar.serialize(value)
  end

  defp parse(type, value) do
    TestSchema.__absinthe_type__(type)
    |> Type.Scalar.parse(value)
  end

  describe ":uuid4" do
    test "serializes a UUID" do
      assert "7587ae8a-9b9f-4bcc-939e-4ddfc8c8a6ab" ==
               serialize(:uuid4, "7587ae8a-9b9f-4bcc-939e-4ddfc8c8a6ab")
    end

    test "serializes nil" do
      assert nil == serialize(:uuid4, nil)
    end

    test "parses a UUID" do
      assert {:ok, "7587ae8a-9b9f-4bcc-939e-4ddfc8c8a6ab"} ==
               parse(:uuid4, %Input.String{value: "7587ae8a-9b9f-4bcc-939e-4ddfc8c8a6ab"})
    end

    test "parses null value" do
      assert {:ok, nil} == parse(:uuid4, %Input.Null{})
    end

    test "fails to parse a non-uuid" do
      assert :error == parse(:uuid4, %Input.String{value: "7587ae8a-9b9f-4bcc-939e"})
    end
  end
end
