defmodule DistributedElixirDemo.Session do
  @moduledoc """
  This module based on GenServer behaviour represents
  user session with visit counter.
  """

  use GenServer

  alias DistributedElixirDemo.SessionSupervisor

  # Let supervisor know how to start a child.
  def child_spec(user_name) do
    %{
      id: "session-" <> user_name,
      start: {__MODULE__, :start_link, [user_name]},
      restart: :transient
    }
  end

  # Start session process with dynamic supervisor.
  def start_supervised(user_name) do
    SessionSupervisor.start_child(user_name)
  end

  # Start session process.
  def start_link(user_name) do
    GenServer.start_link(__MODULE__, [user_name], name: via_tuple(user_name))
  end

  # Increment visits count or start new session. Return the process state.
  @spec visit(binary) :: map | {:error, term} | :ignore
  def visit(user_name) do
    case GenServer.whereis(via_tuple(user_name)) do
      nil ->
        user_name
        |> start_supervised()
        |> get_state()

      pid ->
        GenServer.call(pid, :visit)
    end
  end

  # Build process name
  @spec via_tuple(binary) :: {:via, atom, {atom, tuple}}
  def via_tuple(user_name) do
    {:via, Registry, {Registry.Session, {:session, user_name}}}
  end

  @impl true
  def init([user_name]) do
    {
      :ok,
      %{
        user_name: user_name,
        node: Node.self(),
        visits: 1
      }
    }
  end

  @impl true
  def handle_call(:visit, _pid, state) do
    new_state = %{state | visits: state.visits + 1}
    {:reply, new_state, new_state}
  end

  defp get_state({:ok, pid}), do: :sys.get_state(pid)
  defp get_state(result), do: result
end
