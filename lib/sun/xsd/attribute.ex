defmodule Sun.XSD.Attribute do
  require Record

  Record.defrecord :xmlElement, Record.extract(:xmlElement, from_lib: "xmerl/include/xmerl.hrl")
  Record.defrecord :xmlText,    Record.extract(:xmlText, from_lib: "xmerl/include/xmerl.hrl")

  defstruct name: nil, use: nil, fixed: nil

  def parse_attributes_from_xml(attributes) do
    for attribute <- attributes do
      %Sun.XSD.Attribute{}
      |> add_name(attribute)
      |> add_use(attribute)
      |> add_fixed(attribute)
    end
  end

  defp add_name(map, element) do
    name =
      element
      |> query('/xs:attribute/@name')
      |> fetch_result(8)
    %{map | name: name}
  end

  defp add_use(map, element) do
    name =
      element
      |> query('/xs:attribute/@use')
      |> fetch_result(8)
    %{map | use: name}
  end

  defp add_fixed(map, element) do
    name =
      element
      |> query('/xs:attribute/@fixed')
      |> fetch_result(8)
    %{map | fixed: name}
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
