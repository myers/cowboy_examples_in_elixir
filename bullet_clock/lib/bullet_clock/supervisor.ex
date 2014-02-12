defmodule BulletClock.Supervisor do
  use Supervisor.Behaviour

  def start_link do
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
    :supervisor.start_link({:local, __MODULE__}, __MODULE__, [])
  end

  def init([]) do
    {:ok, {{:one_for_one, 10, 10}, []}}
  end
end