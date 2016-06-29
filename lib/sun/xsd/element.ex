defmodule Sun.XSD.Element do
  import Sun.XML.Parser
  alias Sun.XSD.ComplexType

  defstruct name: nil,
            min_ocurrs: nil,
            max_ocurrs: nil,
            doc: nil,
            default: nil,
            type: nil,
            complex_type: nil

  def parse_elements_from_xml(elements, opts) do
    for element <- elements do
      %Sun.XSD.Element{}
      |> add_name(element)
      |> add_min_occurs(element)
      |> add_max_occurs(element)
      |> add_doc(element)
      |> add_default(element)
      |> add_type(element)
      |> add_complex_type(element, opts)
    end
  end

  defp add_name(map, element) do
    name =
      element
      |> query('/xs:element/@name')
      |> fetch_result(8)
    %{map | name: name}
  end

  defp add_type(map, element) do
    type =
      element
      |> query('/xs:element/@type')
      |> fetch_result(8)
    %{map | type: type}
  end

  defp add_min_occurs(map, element) do
    min_ocurrs =
      element
      |> query('/xs:element/@min_ocurrs')
      |> fetch_result(8)
    %{map | min_ocurrs: min_ocurrs}
  end

  defp add_max_occurs(map, element) do
    max_ocurrs =
      element
      |> query('/xs:element/@max_ocurrs')
      |> fetch_result(8)
    %{map | max_ocurrs: max_ocurrs}
  end

  defp add_doc(map, element) do
    doc =
      element
      |> query('/xs:element/xs:annotation/xs:documentation/text()')
      |> fetch_result(4)
    %{map | doc: doc}
  end

  defp add_default(map, element) do
    doc =
      element
      |> query('/xs:element/@default')
      |> fetch_result(8)
    %{map | default: doc}
  end

  defp add_complex_type(map, element, opts) do
    %{map | complex_type: get_complex_type(map.type, element, opts) }
  end

  defp get_complex_type(nil, element, opts) do
    element
    |> query('/xs:element/xs:complexType')
    |> ComplexType.parse_complex_types_from_xml(opts)
  end

  defp get_complex_type(type, _element, [complex_types: [head|tail], simple_types: simple_types]) do
    if List.to_string(type) === "cfdi:" <> List.to_string(head.name) do
      head
    else
      get_complex_type(type, [], [complex_types: tail, simple_types: simple_types])
    end
  end

  defp get_complex_type(_type, _element, [complex_types: [], simple_types: _simple_types]) do
    nil
  end
end
