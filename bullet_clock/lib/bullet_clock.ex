defmodule BulletClock do
  use Application.Behaviour

  def start(_type, _args) do
    BulletClock.Supervisor.start_link
  end
end
