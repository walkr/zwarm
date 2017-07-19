Zwarm
=========

Start, manage and run a collection of Elixir processes with ease.

### Installation

Add `zwarm` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:zwarm, "~> 0.1.0"}]
end
```


### Usage

```elixir
# Start 10_000 processes
ref = Zwarm.create(10_000, fn -> IO.puts "I am process: #{inspect self()}" end)

# Run function on all processes
Zwarm.run(ref)

# Destroy
Zwarm.destroy(ref)
```


### License

MIT LIcense
