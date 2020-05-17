defmodule DistributedElixirDemo.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :user_name, :string
      add :visits, :integer
    end
  end
end
