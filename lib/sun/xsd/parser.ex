defmodule Sun.XSD.Parser do
  require Record
  alias Sun.XSD.Element

  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText,    Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  defstruct elements: []

  def parse(doc_type) do
    elements = read_xsd(doc_type)
    |> get_elements
    %Sun.XSD.Parser{elements: elements}
  end

  defp get_elements(xsd_doc) do
    :xmerl_xpath.string('/xs:schema/xs:element', xsd_doc)
    |> Element.parse_elements_from_xml
  end

  defp read_xsd(doc_type) do
    {xsd_file, _} = :xmerl_scan.file('priv/xsd_files/#{Atom.to_char_list(doc_type)}.xsd')
    xsd_file
  end
end
