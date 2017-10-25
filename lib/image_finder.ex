defmodule ImageFinder do
  use Application

  def start(_type, _args) do
    ImageFinder.Supervisor.start_link
  end
 
  def fetch(source_files, target_directory) do
    # call ImageFinder for each source file
    #Enum.map source_files, &(process_file(&1, target_directory))
    process_file source_files, target_directory
  end

  def process_file(source_file, target_directory) do
    GenServer.call(ImageFinder.Worker, {:fetch, source_file, target_directory})
  end
end
