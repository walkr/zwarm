defmodule Zwarm.ManagerServer do
    use GenServer

    def start_link(args, opts \\ []) do
        GenServer.start_link __MODULE__, args, opts
    end

    def init(_args) do
        {:ok, %{swarms: Map.new()}}
    end

    def handle_call({:swarm_create, count, fun, args}, _from, state) do
        swarm_ref = make_ref()
        pids = for _ <- 1..count, do: spawn(Zwarm.Unit, :loop, [fun, args])
        new_state = %{state | swarms: Map.put(state.swarms, swarm_ref, pids)}
        {:reply, {:ok, swarm_ref}, new_state}
    end

    def handle_call({:swarm_run, ref}, _from, state) do
        pids = get_swarm_pids(state.swarms, ref)
        Enum.map(pids, fn pid -> send(pid, :run) end)
        {:reply, :ok, state}
    end

    def handle_call({:swarm_status, ref}, _from, state) do
        pids = get_swarm_pids(state.swarms, ref)
        status = Enum.reduce(pids, Map.new(), fn pid, acc -> Map.put(acc, pid, Process.alive?(pid)) end)
        {:reply, status, state}
    end

    def handle_call({:swarm_destroy, ref}, _from, state) do
        {pids, new_swarms} = pop_swarm(state.swarms, ref)
        Enum.map pids, fn pid -> Process.exit(pid, :kill) end
        {:reply, :ok, %{state | swarms: new_swarms}}
    end

    defp get_swarm_pids(swarms, ref) do
        Map.get(swarms, ref) || []
    end

    defp pop_swarm(swarms, ref) do
        {pids, new_swarms} = Map.pop(swarms, ref)
        {pids || [], new_swarms}
    end

end