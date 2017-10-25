defmodule ImageFinder.Worker do
  use GenServer

  def start_link(name) do
    GenServer.start_link(__MODULE__, :ok, name: name)
  end

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_call({:fetch, source_files, target_directory}, _from, state) do
    content = File.read! source_files
    regexp = ~r/http(s?)\:.*?\.(png|jpg|gif)/
    Regex.scan(regexp, content)
      |> Enum.map(&List.first/1)
      |> Enum.map(&(fetch_link &1, target_directory))
    {:reply, :ok, state}
  end

  def fetch_link(link, target_directory) do
    GenServer.call(LinkFetcher.Worker, {:fetch, link, target_directory})
  end

end

