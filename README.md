# Distributed Elixir Demo

This is a Demo application made for meetup presentation to show how to make a distributed system in Elixir using OTP and Horde. It consists of 3 parts. Each part corresponds to particular repo's branch respectively.

- `git checkout 1`. First part is an application which counts user visits to particual url. Here we use a `GenServer` as user session, `Cowboy` server and `Plug` web framework to expose the endpoint, `Dynamic` supervisor to supervise the session process and `Registry` to be able to find this named session in any moment.
- `git checkout 2`.
- `git checkout 3`.
- `git checkout 4`.

Every branch has instructions in it's Readme file.

[Presentation PDF]()



