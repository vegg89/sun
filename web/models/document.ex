defmodule Sun.Document do
  use Sun.Web, :model

  schema "documents" do
    field :json_data, :string

    timestamps
  end

  def creation_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(json_data), [])
  end
end
