# Distributed Elixir Demo

## PART 1 (Simple visits counter)

Here we use a `GenServer` as user session, `Cowboy` server and `Plug` web framework to expose the endpoint, `Dynamic` supervisor to supervise the session process and `Registry` to be able to find this named session in any moment.

### Usage

You should start with downloading and installing dependencies.

`mix deps.get`

It's all. Feel free to start a session in `iex`.

`iex -S mix`

Open your favourite browser and navigate to `localhost:4005`. You should see something like

`Distributed Elixir Demo (Node: nonode@nohost)`

To start user session or/and increment visits just add `user_name` parameter to the url `localhost:4005/?user_name=juanito` the result will be similar to

```
Distributed Elixir Demo (Node: nonode@nohost)
User juanito visited site 1 times.
```

So entering this url over and over again you will notice the visit count incrementing respectively.


