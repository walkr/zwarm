defmodule Zwarm.Unit do
    @moduledoc """
    A process which belongs to a swarm
    """

    def loop(fun, args) do
        receive do
            :run -> case is_nil(fun) do
                        true -> :ok
                        false ->:erlang.apply(fun, args)
                    end
                    loop(fun, args)
            :destroy -> :ok
        end
    end

end