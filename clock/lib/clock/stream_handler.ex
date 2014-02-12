defmodule Clock.StreamHandler do
  @doc "Stream handler for clock synchronizing."
  @period 1000 

  def init(_transport, req, _opts, _active) do
    IO.puts "bullet init"
    tref = :erlang.send_after(@period, self, :refresh)
    {:ok, req, tref}
  end

  def stream("ping: " <> name, req, state) do
    IO.puts "ping #{name} received"
    {:reply, "pong", req, state}
  end
  def stream(data, req, state) do
    IO.puts "stream received #{data}"
    {:ok, req, state}
  end

  def info(:refresh, req, _) do
    tref = :erlang.send_after @period, self, :refresh 
    datetime = :cowboy_clock.rfc1123
    IO.puts "clock refresh timeout #{datetime}"
    {:reply, datetime, req, tref}
  end
  def info(info, req, state) do
    IO.puts "info received #{info}"
    {:ok, req, state}
  end

  def terminate(_req, tref) do
    IO.puts "bullet init"
    :erlang.cancel_timer tref
    {:ok}
  end  
end 
