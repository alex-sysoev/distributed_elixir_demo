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
    build_title() <> "\n" <> "<p><b>User #{user} visited site #{count} times.</b></p>"
  end

  defp build_response(_), do: build_title()

  defp build_title, do: "<h1>Distributed Elixir Demo (Node: #{Node.self()})</h1>"
end
