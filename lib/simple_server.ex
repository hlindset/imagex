defmodule Imagex.SimpleServer do
  use Plug.Router
  use Plug.Debugger

  plug Plug.Static,
    at: "/",
    from: {:imagex, "priv/static"},
    only: ~w(images)

  plug :match
  plug :dispatch

  forward "/process",
    to: Imagex,
    init_opts: [root_url: "http://localhost:4000"]

  match _ do
    send_resp(conn, 404, "404 Not Found")
  end
end
