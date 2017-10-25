defmodule LinkFetcher.Worker do
  @moduledoc false
  


  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:fetch, link, target_directory}, _from, state) do
    HTTPotion.get(link).body |> save(target_directory)
    {:reply, :ok, state}
  end

  def handle_cast(_msg, state) do
    {:noreply, state}
  end

  def save(body, directory) do
    GenServer.call(LinkSaver.Worker, {:save, body, directory})
  end

end



