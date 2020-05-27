defmodule DistributedElixirDemo.NodeManager do
  @moduledoc """
  GenServer that listens to node connection events and
  updates Horde cluster members.
  """

  use GenServer

  alias DistributedElixirDemo.SessionSupervisor

  def child_spec do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [[]]}
    }
  end

  def start_link(_args) do
    GenServer.start_link(__MODULE__, [], name: __MODULE__)
  end

  @impl true
  def init(_) do
    # Monitor Cluster topology
    :net_kernel.monitor_nodes(true, node_type: :visible)

    {:ok, %{}}
  end

  # When the node connects to cluster we got this message.
  @impl true
  def handle_info({:nodeup, _node, _node_type}, state) do
    set_members()
    {:noreply, state}
  end

  # When the node disconnects from cluster we got this message.
  @impl true
  def handle_info({:nodedown, _node, _node_type}, state) do
    set_members()
    {:noreply, state}
  end

  # Set Cluster members for Horde Supervisor and Registry.
  defp set_members() do
    for name <- [Registry.Session, SessionSupervisor] do
      [Node.self() | Node.list()]
      |> Enum.map(fn node -> {name, node} end)
      |> (&Horde.Cluster.set_members(name, &1)).()
    end

    # Task.Supervisor.async_nolink(DistributedElixirDemo.TaskSupervisor, fn ->
    #   :ok = Horde.Cluster.set_members(name, members)
    #   {:ok, :set_members, name}
    # end)
  end
end
