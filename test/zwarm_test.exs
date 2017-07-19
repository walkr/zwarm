defmodule ZwarmTest do
  use ExUnit.Case
  doctest Zwarm

    test "swarm creation" do
        {:ok, ref} = Zwarm.create(10, fn -> :ok end)
        assert Enum.all?(Zwarm.status(ref) |> Map.values, fn alive -> alive == true end)

        {:ok, ref} = Zwarm.create 10, fn pid -> send(pid, :okay) end, [self()]
        Zwarm.run(ref)
        assert_receive :okay, 100
    end

    test "swarm destruction" do
        {:ok, ref} = Zwarm.create(10, fn -> :ok end)
        :ok = Zwarm.destroy(ref)
    end

end
