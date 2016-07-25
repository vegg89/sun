defmodule Sun.XSD.ComplexType do
  import Sun.XML.Parser
  alias Sun.XSD.Element
  alias Sun.XSD.Attribute

  defstruct name: nil,
            attributes: [],
            elements: []

  def parse_complex_types_from_xml(complex_type) do
    parse_complex_types_from_xml(complex_type, complex_types: [], simple_types: [] )
  end

  def parse_complex_types_from_xml(complex_type, opts) do
    %Sun.XSD.ComplexType{}
    |> add_name(complex_type)
    |> add_elements(complex_type, opts)
    |> add_attributes(complex_type, opts)
  end

  defp add_name(map, complex_type) do
    name =
      complex_type
      |> query('/xs:complexType/@name')
      |> fetch_result(8)
    %{map | name: name}
  end

  defp add_elements(map, complex_type, opts) do
    elements =
      complex_type
      |> query('/xs:complexType/xs:sequence/xs:element')
      |> Element.parse_elements_from_xml(opts)
    %{map | elements: elements}
  end

  defp add_attributes(map, complex_type, opts) do
    attributes =
      complex_type
      |> query('/xs:complexType/xs:attribute')
      |> Attribute.parse_attributes_from_xml(opts)
    %{map | attributes: attributes}
  end
end
