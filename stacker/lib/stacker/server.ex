# copied from http://elixir-lang.org/getting_started/mix/2.html
defmodule Stacker.Server do
  use GenServer.Behaviour

  # client 
  def pop do
    :gen_server.call(:stacker, :pop)
  end

  def push(new_item) do
    :gen_server.cast(:stacker, { :push, new_item })
  end

  # server
  def start_link(stack) do
    :gen_server.start_link({ :local, :stacker }, __MODULE__, stack, [])
  end

  def init(stack) do
    { :ok, stack }
  end

  def handle_call(:pop, _from, [h|stack]) do
    { :reply, h, stack }
  end

  def handle_cast({ :push, new }, stack) do
    { :noreply, [new|stack] }
  end
end
