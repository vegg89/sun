defmodule Sun.Repo.Migrations.CreateDocument do
  use Ecto.Migration

  def change do
    create table(:documents) do
      add :json_data, :text, null: false

      timestamps
    end
  end
end
