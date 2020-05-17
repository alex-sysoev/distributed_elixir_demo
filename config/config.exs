import Config

config :distributed_elixir_demo, DistributedElixirDemo.Repo,
  database: "distributed_elixir_demo_repo",
  username: System.get_env("DE_DEMO_DB_USER"),
  password: System.get_env("DE_DEMO_DB_PASSWORD"),
  hostname: "localhost"

  config :distributed_elixir_demo, ecto_repos: [DistributedElixirDemo.Repo]
