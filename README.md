# Distributed Elixir Demo

## PART 2 (Clustered visits counter)

Here we use `libcluster` library to search for nodes according to provided strategy and form a cluster on startup.

### Usage

You should start with downloading and installing dependencies.

`mix deps.get`

Our topology strategy support cluster of 3 nodes named `a@127.0.0.1`, `b@127.0.0.1` and `c@127.0.0.1`. The node names are hard coded to simplify the demo but `libcluster` suppoert different types of strategies including `K8s` dns and others.

Now we can start our node like this

First terminal tab:
`COWBOY_PORT=4005 iex --name a@127.0.0.1 -S mix`

Second tab:
`COWBOY_PORT=4006 iex --name b@127.0.0.1 -S mix`

You will see the following output:

```
14:53:09.930 [info]  [libcluster:demo] connected to :"a@127.0.0.1"
14:53:09.931 [warn]  [libcluster:demo] unable to connect to :"c@127.0.0.1"
```

Sweet. `libcluster` does its job. You can check it by executing `Node.list()` in each node.
