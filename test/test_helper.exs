ExUnit.start

Mix.Task.run "ecto.create", ~w(-r Sun.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r Sun.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(Sun.Repo)

