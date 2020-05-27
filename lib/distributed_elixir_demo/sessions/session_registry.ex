defmodule DistributedElixirDemo.SessionRegistry do
  @moduledoc """
  File based Horde distributed registry for sessions.
  """

  use Horde.Registry

  @name Registry.Session

  def start_link(_, _opts \\ []) do
    Horde.Registry.start_link(__MODULE__, [keys: :unique], name: @name)
  end

  def init(options) do
    options
    |> Keyword.put(:members, members())
    |> Horde.Registry.init()
  end

  defp members do
    [Node.self() | Node.list()]
    |> Enum.map(fn node -> {@name, node} end)
  end
end
