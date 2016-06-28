defmodule Sun.XSD.Document do
  import Sun.XML.Parser
  alias Sun.XSD.Element
  alias Sun.XSD.ComplexType
  alias Sun.XSD.SimpleType

  defstruct elements: [],
            complex_types: [],
            simple_types: []

  def parse(doc_type) do
    xsd = read_xml(doc_type)
    %Sun.XSD.Document{}
    |> add_elements(xsd)
    |> add_simple_types(xsd)
    |> add_complex_types(xsd)

  end

  defp add_elements(map, xsd_doc) do
    elements =
      xsd_doc
      |> query('/xs:schema/xs:element')
      |> Element.parse_elements_from_xml
    %{map | elements: elements}
  end

  defp add_simple_types(map, xsd_doc) do
    simple_types =
      xsd_doc
      |> query('/xs:schema/xs:simpleType')
      |> SimpleType.parse_simple_types_from_xml
    %{map | simple_types: simple_types}
  end

  defp add_complex_types(map, xsd_doc) do
    complex_types =
      xsd_doc
      |> query('/xs:schema/xs:complexType')
      |> ComplexType.parse_complex_types_from_xml
    %{map | complex_types: complex_types}
  end
end
