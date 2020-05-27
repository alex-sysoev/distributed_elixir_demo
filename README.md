# Distributed Elixir Demo

This is a Demo application made for meetup presentation to show how to make a distributed system in Elixir using OTP and Horde. It consists of 4 parts. Each part corresponds to particular repo's branch respectively.

- [`git checkout simple-visits-counter`](https://github.com/alex-sysoev/distributed_elixir_demo/tree/simple-visits-counter). First part is an application which counts user visits to particual url. Here we use a `GenServer` as user session, `Cowboy` server and `Plug` web framework to expose the endpoint, `Dynamic` supervisor to supervise the session process and `Registry` to be able to find this named session in any moment.
- [`git checkout clustered-visits-counter`](https://github.com/alex-sysoev/distributed_elixir_demo/tree/clustered-visits-counter). Second part is the same app but with automatic node connection. Here we use `libcluster` library to search for nodes according to provided strategy and form a cluster on startup.
- [`git checkout distributed-visits-counter`](https://github.com/alex-sysoev/distributed_elixir_demo/tree/distributed-visits-counter). Third part is a distributed application now. Here we use `Horde.DynamicSupervisor` and `Horde.Registry` to make user sessions visible and balanced across all the nodes in our cluster.
- [`git checkout hand-off-visits-counter`](https://github.com/alex-sysoev/distributed_elixir_demo/tree/hand-off-visits-counter). In the fourth part we no longer loose the session's state when it dies. Here we use `postgres` database to temporary save the session state and avoid loosing it.

Every branch has instructions in it's Readme file.

[Presentation PDF](https://github.com/alex-sysoev/distributed_elixir_demo/tree/master/distributed-elixir-demo.pdf)



