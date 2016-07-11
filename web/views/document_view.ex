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

  def generate_element_section(%Sun.XSD.Element{complex_type: complex_type, name: name, max_ocurrs: "unbounded"}) do
    render "table.html", element: %Sun.XSD.Element{complex_type: complex_type, name: name}
  end

  def generate_element_section(%Sun.XSD.Element{complex_type: complex_type, name: name}) do
    render "single.html", element: %Sun.XSD.Element{complex_type: complex_type, name: name}
  end

  def generate_panel_heading(%Sun.XSD.Element{max_ocurrs: "unbounded", name: name}) do
    title = content_tag(:h3, class: "panel-title pull-left", style: "padding-top: 7.5px;") do
      name
    end
    button = content_tag(:div, class: "btn-group pull-right") do
      link("Agregar", to: "#", id: "new_#{name}", class: "btn btn-primary", type: "button")
    end
    {:safe, [elem(title,1)|elem(button,1)]}
  end

  def generate_panel_heading(%Sun.XSD.Element{name: name}) do
    content_tag(:h3, class: "panel-title pull-left") do
      name
    end
  end
end
