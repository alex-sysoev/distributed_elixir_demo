defmodule DistributedElixirDemo.Repo do
  use Ecto.Repo,
    otp_app: :distributed_elixir_demo,
    adapter: Ecto.Adapters.Postgres
end
