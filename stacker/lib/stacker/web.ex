defmodule Stacker.Web do
  def start() do
    dispatch = [
      {:_, [
        {"/", :cowboy_static, {:priv_file, :stacker, "static/index.html"}},
        {"/stacker/[...]", :sockjs_cowboy_handler, :sockjs_handler.init_state("/stacker", &stacker/3, :state, [])},
        # catch all.  Must be last in the list
        {"/[...]", :cowboy_static, {:priv_dir, :stacker, "static"}},
      ]}
    ] |> :cowboy_router.compile

    {:ok, _} = :cowboy.start_http(:http, 100, [port: 8080], [env: [dispatch: dispatch]])
    IO.puts "Starting server http://localhost:8080/ ... (Ctrl-c, q, <enter> to stop)"
  end

  def stacker(_conn, :init, :state) do
    IO.puts "#{inspect(self)}: init"
    {:ok, :state}
  end
  def stacker(conn, {:recv, data}, :state) do
    IO.puts "#{inspect(self)}: Got request #{inspect(data)}"
    {:ok, decoded_data} = JSEX.decode data
    IO.puts "#{inspect(self)}: stream received decoded #{inspect(decoded_data)}"
    case decoded_data do
      ["push", new_stack_item] ->
        Stacker.Server.push new_stack_item
      ["pop"] ->
        conn.send(Stacker.Server.pop)
    end
  end
  def stacker(_conn, {:info, info}, :state) do
    IO.puts "#{inspect(self)}: info #{inspect(info)}"
    {:ok, :state}
  end
  def stacker(_conn, :closed, :state) do
    IO.puts "#{inspect(self)}: closed"
    {:ok, :state}
  end
end