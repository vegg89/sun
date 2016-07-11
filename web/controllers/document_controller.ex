defmodule Sun.DocumentController do
  use Sun.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def new(conn, %{"type" => type}) do
    IO.puts type
    render conn, "new.html", type: type
  end

  def create(conn, _params) do
    render conn, "create.html"
  end
end
