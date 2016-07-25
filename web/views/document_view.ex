defmodule Sun.DocumentView do
  use Sun.Web, :view
  alias Sun.XSD.Document

  def render_form(doc_type, conn) do
    Document.parse(doc_type)
    |> generate_form(conn)
  end

  defp generate_form(document, conn) do
    render "form.html", conn: conn, document: document
  end

  def generate_element_section(%{complex_type: complex_type, name: name, max_ocurrs: "unbounded"}) do
    render "table.html", element: %{complex_type: complex_type, name: name}
  end

  def generate_element_section(%{complex_type: complex_type, name: name}) do
    render "single.html", element: %{complex_type: complex_type, name: name}
  end

  def generate_panel_heading(%{max_ocurrs: "unbounded", name: name}) do
    title = content_tag(:h3, class: "panel-title pull-left", style: "padding-top: 7.5px;") do
      name
    end
    button = content_tag(:div, class: "btn-group pull-right") do
      link("Agregar", to: "#", id: "new_#{name}", class: "btn btn-primary", type: "button")
    end
    {:safe, [elem(title,1)|elem(button,1)]}
  end

  def generate_panel_heading(%{name: name}) do
    content_tag(:h3, class: "panel-title pull-left") do
      name
    end
  end

  #HTML controls generators
  #Textbox
  def generate_control(%{name: name, simple_type: %{base: "xs:string", enumerations: []}, fixed: nil}, parent_name) do
    render "textbox.html", name: name, parent_name: parent_name
  end
  #$ Amount
  def generate_control(%{name: name, simple_type: %{base: "xs:decimal", enumerations: []}, fixed: nil}, parent_name) do
    render "amountbox.html", name: name, parent_name: parent_name
  end
  #DatePicker
  def generate_control(%{name: name, simple_type: %{base: "xs:date", enumerations: []}, fixed: nil}, parent_name) do
    render "datepicker.html", name: name, parent_name: parent_name
  end
  #DateTimePicker
  def generate_control(%{name: name, simple_type: %{base: "xs:dateTime", enumerations: []}, fixed: nil}, parent_name) do
    render "datetimepicker.html", name: name, parent_name: parent_name
  end
  #Number Textbox
  def generate_control(%{name: name, simple_type: %{base: base, enumerations: []}, fixed: nil}, parent_name) when base == "xs:integer" or base == "xs:int" do
    render "numberbox.html", name: name, parent_name: parent_name
  end
  #Combobox
  def generate_control(%{name: name, simple_type: %{enumerations: enums}, fixed: nil}, parent_name) do
    options =
      for enum <- enums do
        {"#{enum}", enum}
      end
    render "combobox.html", name: name, parent_name: parent_name, options: options
  end
  #Hidden
  def generate_control(%{name: name, fixed: value }, parent_name) do
    hidden_input(String.to_atom(parent_name), String.to_atom(name), value: value)
  end
end
