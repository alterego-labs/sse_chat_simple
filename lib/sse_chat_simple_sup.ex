defmodule SseChatSimpleSup do
  use Supervisor

  def start_link do
    Supervisor.start_link __MODULE__, :ok
  end

  def init(:ok) do
    {:ok, {{:one_for_one, 10, 10}, []}}
  end
end
