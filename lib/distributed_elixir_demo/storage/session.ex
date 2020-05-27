defmodule DistributedElixirDemo.Storage.Session do
  @moduledoc """
  Storage model to store user session.
  """

  use Ecto.Schema

  schema "sessions" do
    field(:user_name, :string)
    field(:visits, :integer)
  end

  def changeset(session, params \\ %{}) do
    session
    |> Ecto.Changeset.cast(params, [:user_name, :visits])
  end
end
