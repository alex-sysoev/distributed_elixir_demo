defmodule DistributedElixirDemo.Storage do
  @moduledoc """
  This module keeps functionality to backup and restore
  user sessions to/from database.
  """

  alias DistributedElixirDemo.Repo
  alias DistributedElixirDemo.Storage.Session

  import Ecto.Query

  @doc """
  Save session to database.
  """
  @spec backup(map) :: {:ok, struct} | {:error, term}
  def backup(params = %{user_name: _, visits: _}) do
    %Session{}
    |> Session.changeset(params)
    |> Repo.insert()
  end

  def backup(_), do: {:error, "Wrong state format"}

  @doc """
  Read session from database.
  """
  @spec restore(binary) :: struct | nil
  def restore(name) do
    Repo.get_by(Session, user_name: name)
  end

  @doc """
  Remove backup
  """
  @spec cleanup(binary) :: :ok
  def cleanup(name) do
    Session
    |> where(user_name: ^name)
    |> Repo.delete_all()
  end
end
