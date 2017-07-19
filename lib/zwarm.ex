defmodule Zwarm do
    @moduledoc """

    Zwarm allows you to start, manage and run a collection of
    identical processes with ease.

    ## Usage

        # Create a swarm of three processes
        ref = Zwarm.create!(3, fn -> IO.puts "Hello" end)

        # Run them all
        Zwarm.run(ref)

        # Destroy
        Zwarm.destroy(ref)

    """

    @doc """
    Create a swarm of `count` processes
    """

    def create(count), do: Zwarm.Manager.create(count, nil, nil)

    @doc """
    Create a swarm of `count` process, and supply a function and its args
    to be executed by each individual process when `Zwarm.run` is called
    """
    def create(count, fun, args \\ []) when count >= 1 and is_function(fun),
        do: Zwarm.Manager.create(count, fun, args)

    @doc """
    Create a swarm of `count` processes, but raise if it fails
    """
    def create!(count) do
        {:ok, ref} = create(count)
        ref
    end

    @doc """
    Create swarm with additional function and args. Raise exception if it fails
    """
    def create!(count, fun, args \\ []) do
        {:ok, ref} = create(count, fun, args)
        ref
    end

    @doc """
    Instruct a swarm to execute function on all its processes
    """
    def destroy(swarm_ref), do: Zwarm.Manager.destroy(swarm_ref)

    @doc """
    Get status of a swarm
    """
    def status(swarm_ref), do: Zwarm.Manager.status(swarm_ref)

    @doc """
    Direct all swarm's processes to run
    """
    def run(swarm_ref), do: Zwarm.Manager.run(swarm_ref)

end
