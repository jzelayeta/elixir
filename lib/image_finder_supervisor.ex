defmodule ImageFinder.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, :ok)
  end

  def init(:ok) do
    # define supervisors
    children = [
      supervisor(LinkSaverSupervisor.Supervisor, [], [LinkSaverSupervisor.Supervisor]),
      supervisor(LinkFetcherSupervisor.Supervisor, [], [LinkFetcherSupervisor.Supervisor]),
      worker(ImageFinder.Worker, [ImageFinder.Worker])
    ]
    supervise(children, strategy: :one_for_one)
  end
end
