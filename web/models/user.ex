defmodule Sun.User do
  use Sun.Web, :model

  schema "users" do
    field :username, :string

    timestamps
  end

  def creation_changeset(model, params \\ :empty) do
    model
    |> cast(params, ~w(username), [])
  end
end
