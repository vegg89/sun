defmodule Sun.XML.Parser do
  require Record

  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText,    Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  def read_xml(doc_type) do
    {xsd_file, _} = :xmerl_scan.file('priv/xsd_files/#{Atom.to_char_list(doc_type)}.xsd')
    xsd_file
  end

  def query(element, xpath) do
    :xmerl_xpath.string(xpath, element)
  end

  def fetch_result([head|_], index) do
    List.to_string(elem(head, index))
  end

  def fetch_result([], _) do
    nil
  end
end
