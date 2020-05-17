# Distributed Elixir Demo

## PART 4 (Hand-off visits counter)

Here we use `postgres` database to temporary save the session state and avoid loosing it.

### Usage

You should start with downloading and installing dependencies.

`mix deps.get`

In this part we install `ecto` so in order to connect the app to database you should provide credentials.

```
export DE_DEMO_DB_USER=xxx
export DE_DEMO_DB_PASSWORD=xxx
```

Then create and migrate your database.

```
mix ecto.create
mix ecto.migrate
```

Starting process is the same. One terminal tab per node and run `COWBOY_PORT={port} iex --name {letter}@127.0.0.1 -S mix` in each tab.

Now if you open your browser one tab per node and navigate to `localhost:{port}/?user_name=juanito` respectively you'll see that know each request effects to visits count of the user.

You can test state consistance running `System.stop()` on one of your nodes that has sessions on it or terminating abnormally session servers.
Update the dashboard at `localhost:{port}` and you'll see the same state as before.

Sweet! We don't loose state now.
