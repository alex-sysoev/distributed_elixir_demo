defmodule DistributedElixirDemo.Plug.Router do
  use Plug.Router

  alias DistributedElixirDemo.Session

  plug(Plug.Parsers, parsers: [:urlencoded], pass: ["text/*"])

  plug(:match)
  plug(:dispatch)

  # Health check home page.
  get "/" do
    send_resp(conn, 200, build_response(conn))
  end

  match _ do
    send_resp(conn, 404, "oops")
  end

  defp build_response(%Plug.Conn{params: %{"user_name" => user}}) do
    %{visits: count} = Session.visit(user)
    build_title() <> "\n" <> "<h2>User #{user} visited site #{count} times.</h2>"
  end

  defp build_response(_) do
    Registry.Session
    |> Horde.Registry.select([{{:"$1", :"$2", :"$3"}, [], [{{:"$1", :"$2", :"$3"}}]}])
    |> Enum.filter(fn {{_, user}, _, _} -> GenServer.whereis(Session.via_tuple(user)) end)
    |> Enum.map(fn {_, pid, _} -> "<h2>" <> "#{:sys.get_state(pid).user_name}: #{:sys.get_state(pid).visits} (#{:sys.get_state(pid).node}) " <> "</h2>" end)
    |> (&[build_title() | &1]).()
    |> Enum.join("\n")
  end

  defp build_title, do: "<h1>Distributed Elixir Demo (#{Node.self()})</h1>"
end
