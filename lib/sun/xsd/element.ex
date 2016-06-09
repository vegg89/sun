defmodule Sun.XSD.Element do
  require Record
  alias Sun.XSD.Attribute

  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText,    Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  defstruct name: nil, attributes: [], min_ocurrs: nil, max_ocurrs: nil, doc: nil, elements: [], type: nil

  def parse_elements_from_xml(elements) do
    for element <- elements do
      %Sun.XSD.Element{}
      |> add_name(element)
      |> add_min_occurs(element)
      |> add_max_occurs(element)
      |> add_doc(element)
      |> add_attributes(element)
      |> add_elements(element)
    end
  end

  defp add_name(map, element) do
    name =
      element
      |> query('/xs:element/@name')
      |> fetch_result(8)
    %{map | name: name}
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

  defp add_attributes(map, element) do
    attributes =
      element
      |> query('/xs:element/xs:complexType/xs:attribute')
      |> Attribute.parse_attributes_from_xml
    %{map | attributes: attributes}
  end

  defp add_elements(map, element) do
    elements =
      element
      |> query('/xs:element/xs:complexType/xs:sequence/xs:element')
      |> parse_elements_from_xml
    %{map | elements: elements}
  end

  defp query(element, xpath) do
    :xmerl_xpath.string(xpath, element)
  end

  defp fetch_result([head|_], index) do
    elem(head, index)
  end

  defp fetch_result([], _) do
    nil
  end
end
