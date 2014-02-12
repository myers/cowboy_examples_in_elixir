defmodule SockjsEcho.Responder do
  def echo(_conn, :init, :state) do
    IO.puts "#{inspect(self)}: init"
    {:ok, :state}
  end
  def echo(conn, {:recv, data}, :state) do
    IO.puts "#{inspect(self)}: echoing back #{inspect(data)}"
    conn.send(data)
  end
  def echo(_conn, {:info, info}, :state) do
    IO.puts "#{inspect(self)}: info #{inspect(info)}"
    {:ok, :state}
  end
  def echo(_conn, :closed, :state) do
    IO.puts "#{inspect(self)}: closed"
    {:ok, :state}
  end
end