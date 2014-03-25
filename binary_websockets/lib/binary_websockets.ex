defmodule BinaryWebsockets do
  use Application.Behaviour


  def start(_type, [:test]) do
    # don't run the app in test mode
    {:ok, self}
  end
  def start(_type, _args) do
    dispatch = [
      {:_, [
        {"/", :cowboy_static, {:priv_file, :binary_websockets, "static/index.html"}},
        {"/websocket", BinaryWebsockets.WebsocketHandler, []},
        # catch all.  Must be last in the list
        {"/[...]", :cowboy_static, {:priv_dir, :binary_websockets, "static"}},
      ]}
    ] |> :cowboy_router.compile

    {:ok, _} = :cowboy.start_http(:http, 100, [port: 8080], [env: [dispatch: dispatch]])
    IO.puts "Starting server http://localhost:8080/ ... (Ctrl-c, q, <enter> to stop)"

    BinaryWebsockets.Supervisor.start_link
  end
end
