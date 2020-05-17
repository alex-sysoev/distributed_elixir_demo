defmodule DistributedElixirDemo.Application do
  @moduledoc false

  use Application

  alias DistributedElixirDemo.Plug.Router
  alias DistributedElixirDemo.SessionSupervisor

  def start(_type, _args) do
    port = String.to_integer(System.get_env("COWBOY_PORT") || "4005")

    children = [
      {Registry, keys: :unique, name: Registry.Session},
      SessionSupervisor,
      Plug.Cowboy.child_spec(scheme: :http, plug: Router, options: [port: port]),
      {Cluster.Supervisor, [topologies(), [name: DistributedElixirDemo.ClusterSupervisor]]}
    ]

    opts = [strategy: :one_for_one, name: DistributedElixirDemo.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp topologies do
    [
      demo: [
        strategy: Elixir.Cluster.Strategy.Epmd,
        config: [hosts: [:"a@127.0.0.1", :"b@127.0.0.1", :"c@127.0.0.1"]]
      ]
    ]
  end
end
