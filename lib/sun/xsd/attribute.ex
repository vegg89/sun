defmodule Sun.XSD.Attribute do
  import Sun.XML.Parser
  alias Sun.XSD.SimpleType

  defstruct name: nil, use: nil, fixed: nil, type: nil, simple_type: nil

  def parse_attributes_from_xml(attributes, opts) do
    for attribute <- attributes do
      %Sun.XSD.Attribute{}
      |> add_name(attribute)
      |> add_use(attribute)
      |> add_fixed(attribute)
      |> add_type(attribute)
      |> add_simple_type(attribute, opts)
    end
  end

  defp add_name(map, attribute) do
    name =
      attribute
      |> query('/xs:attribute/@name')
      |> fetch_result(8)
    %{map | name: name}
  end

  defp add_use(map, attribute) do
    use =
      attribute
      |> query('/xs:attribute/@use')
      |> fetch_result(8)
    %{map | use: use}
  end

  defp add_fixed(map, attribute) do
    fixed =
      attribute
      |> query('/xs:attribute/@fixed')
      |> fetch_result(8)
    %{map | fixed: fixed}
  end

  defp add_type(map, attribute) do
    type =
      attribute
      |> query('/xs:attribute/@type')
      |> fetch_result(8)
    %{map | type: type}
  end

  defp add_simple_type(map, attribute, opts) do
    type = get_type(map.type)
    %{map | simple_type: get_simple_type(type, attribute, opts) }
  end

  defp get_simple_type(nil, attribute, _opts) do
    attribute
    |> query('/xs:attribute/xs:simpleType')
    |> hd
    |> SimpleType.parse_simple_types_from_xml
  end

  defp get_simple_type(type, _attribute, [complex_types: complex_types, simple_types: [head|tail]]) do
    if type === head.name do
      head
    else
      get_simple_type(type, [], [complex_types: complex_types, simple_types: tail])
    end
  end

  defp get_simple_type(_type, _element, [complex_types: _complex_types, simple_types: []]) do
    nil
  end

  defp get_type(nil) do
    nil
  end

  defp get_type(type) do
    String.split(type, ":")
    |> tl
    |> hd
  end
end
