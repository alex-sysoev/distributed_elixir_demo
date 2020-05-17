# Distributed Elixir Demo

## PART 3 (Distributed visits counter)

Here we use `Horde.DynamicSupervisor` and `Horde.Registry` to make user sessions visible and balanced across all the nodes in our cluster.

### Usage

You should start with downloading and installing dependencies.

`mix deps.get`

Starting process is the same. One terminal tab per node and run `COWBOY_PORT={port} iex --name {letter}@127.0.0.1 -S mix` in each tab.

Now if you open your browser one tab per node and navigate to `localhost:{port}/?user_name=juanito` respectively you'll see that know each request effects to visits count of the user.

Sweet! Sessions are distributed.
