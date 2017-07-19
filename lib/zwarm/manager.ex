defmodule Zwarm.Manager do

    ### API #####

    @doc """
    Createa swarm of `count` processes
    """
    def create(count) do
        :ok = maybe_create_swarm_manager()
        call({:swarm_create, count})
    end

    def create(count, fun, args \\ []) do
        :ok = maybe_create_swarm_manager()
        call({:swarm_create, count, fun, args})
    end

    def run(swarm_ref),     do: call({:swarm_run, swarm_ref})
    def destroy(swarm_ref), do: call({:swarm_destroy, swarm_ref})
    def status(swarm_ref),  do: call({:swarm_status, swarm_ref})


    ### PRIVATE #####

    defp call(msg),         do: GenServer.call(Zwarm.ManagerServer, msg)

    defp maybe_create_swarm_manager() do
        case Process.whereis(Zwarm.ManagerServer) do
            nil ->
                {:ok, _pid} = Zwarm.ManagerServer.start_link(:ok, name: Zwarm.ManagerServer)
                :ok
            _ -> :ok
        end
    end


end