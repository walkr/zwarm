defmodule Zwarm do
    @moduledoc """
    Documentation for Zwarm.
    """

    @doc """
    Create a swarm of `count` processes, which can execute
    a function with optional arguments
    """

    def create(count), do: Zwarm.Manager.create(count, nil, nil)
    def create(count, fun, args \\ []) when count >= 1 and is_function(fun),
        do: Zwarm.Manager.create(count, fun, args)

    def create!(count) do
        {:ok, ref} = create(count)
        ref
    end

    def create!(count, fun, args \\ []) do
        {:ok, ref} = create(count, fun, args)
        ref
    end

    @doc """
    Destroy a swarm
    """
    def destroy(swarm_ref), do: Zwarm.Manager.destroy(swarm_ref)

    @doc """
    Get status of swarm
    """
    def status(swarm_ref), do: Zwarm.Manager.status(swarm_ref)

    @doc """
    Run swarm
    """
    def run(swarm_ref), do: Zwarm.Manager.run(swarm_ref)

end
