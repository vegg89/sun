defmodule Sun.DocumentView do
  use Sun.Web, :view
  alias Sun.XSD.Parser

  def render_form(doc_type, conn) do
    Parser.parse(doc_type)
    |> generate_form(conn)
  end

  defp generate_form(elements, conn) do
    render "form.html", conn: conn, elements: elements
  end
end
