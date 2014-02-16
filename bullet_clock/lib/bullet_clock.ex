defmodule BulletClock do
  use Application.Behaviour

  def start(_type, _args) do
    dispatch = [
      {:_, [
        {"/", :cowboy_static, {:priv_file, :bullet_clock, "static/index.html"}},
        {"/bullet_js/[...]", :cowboy_static, {:priv_dir, :bullet, ""}},

        {"/bullet", :bullet_handler, [{:handler, BulletClock.StreamHandler}]},

        # catch all.  Must be last in the list
        {"/[...]", :cowboy_static, {:priv_dir, :bullet_clock, "static"}},
      ]}
    ] |> :cowboy_router.compile

    {:ok, _} = :cowboy.start_http(:http, 100, [port: 8080], [env: [dispatch: dispatch]])
    IO.puts "Starting server http://localhost:8080/ ... (Ctrl-c, q, <enter> to stop)"
    
    BulletClock.Supervisor.start_link
  end
end
