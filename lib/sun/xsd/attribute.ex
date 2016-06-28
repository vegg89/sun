defmodule Sun.XSD.Attribute do
  import Sun.XML.Parser
  alias Sun.XSD.SimpleType

  defstruct name: nil, use: nil, fixed: nil, type: nil, simple_types: []

  def parse_attributes_from_xml(attributes) do
    for attribute <- attributes do
      %Sun.XSD.Attribute{}
      |> add_name(attribute)
      |> add_use(attribute)
      |> add_fixed(attribute)
      |> add_type(attribute)
      |> add_simple_types(attribute)
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
      |> query('/xs:attribute/@fixed')
      |> fetch_result(8)
    %{map | fixed: type}
  end

  defp add_simple_types(map, attribute) do
    simple_types =
      attribute
      |> query('/xs:attribute/xs:simpleType')
      |> SimpleType.parse_simple_types_from_xml
    %{map | simple_types: simple_types}
  end
end
