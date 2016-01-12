defmodule GraphQL.Type.Float do
  defstruct name: "Float", description: "IEEE Floating point"

  def coerce(value) when is_binary(value) do
    case Float.parse(value) do
      :error -> nil
      {found,_} -> coerce(found)
    end
  end
  def coerce(false), do: 0
  def coerce(true), do: 1
  def coerce(value) do
    value = value * 1.0
  end
end

defimpl GraphQL.Types, for: GraphQL.Type.Float do
  def parse_value(_, value), do: GraphQL.Type.Float.coerce(value)
  def serialize(_, value), do: GraphQL.Type.Float.coerce(value)
end
