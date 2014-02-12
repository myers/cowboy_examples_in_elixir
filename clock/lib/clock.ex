defmodule Clock do
  use Application.Behaviour

  def start(_type, _args) do
    Clock.Supervisor.start_link
  end
end
