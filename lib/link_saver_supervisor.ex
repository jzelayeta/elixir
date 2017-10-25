defmodule LinkSaverSupervisor.Supervisor do
  @moduledoc false
  


  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    children = [
      worker(LinkSaver.Worker, [LinkSaver.Worker])
    ]

    supervise(children, strategy: :one_for_one)
  end
end