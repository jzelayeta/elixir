defmodule LinkSaver.Worker do
  @moduledoc false
  


  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:save, body, target_directory}, _from, state) do
    File.write! "#{target_directory}/#{digest(body)}", body
    {:reply, :ok, state}
  end

  def handle_cast(_msg, state) do
    {:noreply, state}
  end

  def digest(body) do
    :crypto.hash(:md5 , body) |> Base.encode16()
  end

end