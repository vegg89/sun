defmodule Sun.XSD.Document do
  import Sun.XML.Parser
  alias Sun.XSD.Element
  alias Sun.XSD.ComplexType
  alias Sun.XSD.SimpleType

  defstruct elements: []

  def parse(doc_type) do
    xsd = read_xml(doc_type)
    simple_types = get_simple_types(xsd)
    complex_types = get_complex_types(xsd)
    %Sun.XSD.Document{}
      |> add_elements(xsd, complex_types: complex_types, simple_types: simple_types)
  end

  defp add_elements(map, xsd_doc, opts) do
    elements =
      xsd_doc
      |> query('/xs:schema/xs:element')
      |> Element.parse_elements_from_xml(opts)
    %{map | elements: elements}
  end

  defp get_simple_types(xsd_doc) do
    xsd_doc
    |> query('/xs:schema/xs:simpleType')
    |> SimpleType.parse_simple_types_from_xml
  end

  defp get_complex_types(xsd_doc) do
    xsd_doc
    |> query('/xs:schema/xs:complexType')
    |> ComplexType.parse_complex_types_from_xml
  end
end
