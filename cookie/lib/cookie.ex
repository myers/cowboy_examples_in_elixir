defmodule Cookie do
  use Application.Behaviour

  def start(_type, _args) do
    dispatch = [
      {:_, [
        {"/", :cowboy_static, {:priv_file, :cookie, "static/index.html"}},
      ]}
    ] |> :cowboy_router.compile

    {:ok, _} = :cowboy.start_http(:http, 100, [port: 8080], [
      env: [dispatch: dispatch],
      middlewares: [:cowboy_router, Cookie.SessionMiddleware, :cowboy_handler]
    ])
    IO.puts "Starting server http://localhost:8080/ ... (Ctrl-c, q, <enter> to stop)"

    Cookie.Supervisor.start_link
  end
end
