defmodule DistributedElixirDemo.SessionSupervisor do
  @moduledoc """
  Dynamic supervisor to manage session lifecycle.
  """

  use Horde.DynamicSupervisor

  alias DistributedElixirDemo.Session

  def start_link(_args, _opts \\ []) do
    Horde.DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def start_child(user_name) do
    Horde.DynamicSupervisor.start_child(__MODULE__, Session.child_spec(user_name))
  end

  @impl true
  def init(_args) do
    Horde.DynamicSupervisor.init(strategy: :one_for_one, members: members(), shutdown: 10_000)
  end

  defp members do
    [Node.self() | Node.list()]
    |> Enum.map(fn node -> {__MODULE__, node} end)
  end
end
