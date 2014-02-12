defmodule SockjsEcho.Supervisor do
  use Supervisor.Behaviour

  def start_link do
    dispatch = [
      {:_, [
        {"/", :cowboy_static, {:priv_file, :sockjs_echo, "static/index.html"}},
        {"/echo/[...]", :sockjs_cowboy_handler, :sockjs_handler.init_state("/echo", &SockjsEcho.Responder.echo/3, :state, [])},
        # catch all.  Must be last in the list
        {"/[...]", :cowboy_static, {:priv_dir, :sockjs_echo, "static"}},
      ]}
    ] |> :cowboy_router.compile

    {:ok, _} = :cowboy.start_http(:http, 100, [port: 8080], [env: [dispatch: dispatch]])
    IO.puts "Starting server http://localhost:8080/ ... (Ctrl-c, q, <enter> to stop)"
    :supervisor.start_link({:local, __MODULE__}, __MODULE__, [])
  end

  def init([]) do
    {:ok, {{:one_for_one, 10, 10}, []}}
  end

end
