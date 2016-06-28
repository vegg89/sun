defmodule Sun.XSD.SimpleType do
  import Sun.XML.Parser

  defstruct name: nil,
            enumerations: [],
            fraction_digits: nil,
            length: nil,
            max_exclusive: nil,
            max_inclusive: nil,
            max_length: nil,
            min_exclusive: nil,
            min_inclusive: nil,
            min_length: nil,
            pattern: nil,
            total_digits: nil,
            white_space: nil

  def parse_simple_types_from_xml(simple_types) do
    for simple_type <- simple_types do
      %Sun.XSD.SimpleType{}
      |> add_name(simple_type)
      |> add_enumerations(simple_type)
      |> add_fraction_digits(simple_type)
      |> add_length(simple_type)
      |> add_max_exclusive(simple_type)
      |> add_max_inclusive(simple_type)
      |> add_max_length(simple_type)
      |> add_min_exclusive(simple_type)
      |> add_min_inclusive(simple_type)
      |> add_min_length(simple_type)
      |> add_pattern(simple_type)
      |> add_total_digits(simple_type)
      |> add_white_space(simple_type)
    end
  end

  defp add_name(map, complex_type) do
    name =
      complex_type
      |> query('/xs:simpleType/@name')
      |> fetch_result(8)
    %{map | name: name}
  end

  defp add_enumerations(map, simple_type) do
    enumerations =
      simple_type
      |> query('/xs:simpleType/xs:restriction/xs:enumeration/@value')
      |> fetch_result(8)
    %{map | enumerations: enumerations}
  end

  defp add_fraction_digits(map, simple_type) do
    fraction_digits =
      simple_type
      |> query('/xs:simpleType/xs:restriction/xs:fractionDigits/@value')
      |> fetch_result(8)
    %{map | fraction_digits: fraction_digits}
  end

  defp add_length(map, simple_type) do
    length =
      simple_type
      |> query('/xs:simpleType/xs:restriction/xs:length/@value')
      |> fetch_result(8)
    %{map | length: length}
  end

  defp add_max_exclusive(map, simple_type) do
    max_exclusive =
      simple_type
      |> query('/xs:simpleType/xs:restriction/xs:maxExclusive/@value')
      |> fetch_result(8)
    %{map | max_exclusive: max_exclusive}
  end

  defp add_max_inclusive(map, simple_type) do
    max_inclusive =
      simple_type
      |> query('/xs:simpleType/xs:restriction/xs:maxInclusive/@value')
      |> fetch_result(8)
    %{map | max_inclusive: max_inclusive}
  end

  defp add_max_length(map, simple_type) do
    max_length =
      simple_type
      |> query('/xs:simpleType/xs:restriction/xs:maxLength/@value')
      |> fetch_result(8)
    %{map | max_length: max_length}
  end

  defp add_min_exclusive(map, simple_type) do
    min_exclusive =
      simple_type
      |> query('/xs:simpleType/xs:restriction/xs:minExclusive/@value')
      |> fetch_result(8)
    %{map | min_exclusive: min_exclusive}
  end

  defp add_min_inclusive(map, simple_type) do
    min_inclusive =
      simple_type
      |> query('/xs:simpleType/xs:restriction/xs:minInclusive/@value')
      |> fetch_result(8)
    %{map | min_inclusive: min_inclusive}
  end

  defp add_min_length(map, simple_type) do
    min_length =
      simple_type
      |> query('/xs:simpleType/xs:restriction/xs:minLength/@value')
      |> fetch_result(8)
    %{map | min_length: min_length}
  end

  defp add_pattern(map, simple_type) do
    pattern =
      simple_type
      |> query('/xs:simpleType/xs:restriction/xs:pattern/@value')
      |> fetch_result(8)
    %{map | pattern: pattern}
  end

  defp add_total_digits(map, simple_type) do
    total_digits =
      simple_type
      |> query('/xs:simpleType/xs:restriction/xs:totalDigits/@value')
      |> fetch_result(8)
    %{map | total_digits: total_digits}
  end

  defp add_white_space(map, simple_type) do
    white_space =
      simple_type
      |> query('/xs:simpleType/xs:restriction/xs:whiteSpace/@value')
      |> fetch_result(8)
    %{map | white_space: white_space}
  end
end
