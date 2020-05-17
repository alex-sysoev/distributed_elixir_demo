defmodule DistributedElixirDemo.SessionSupervisor do
  @moduledoc """
  Dynamic supervisor to manage session lifecycle.
  """

  use DynamicSupervisor

  alias DistributedElixirDemo.Session

  def start_link(args) do
    DynamicSupervisor.start_link(__MODULE__, args, name: __MODULE__)
  end

  def start_child(user_name) do
    DynamicSupervisor.start_child(__MODULE__, Session.child_spec(user_name))
  end

  @impl true
  def init(_args) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end
end
