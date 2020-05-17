defmodule DistributedElixirDemoTest do
  use ExUnit.Case
  doctest DistributedElixirDemo

  test "greets the world" do
    assert DistributedElixirDemo.hello() == :world
  end
end
