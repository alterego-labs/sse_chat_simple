defmodule Mix.Tasks.Server do
  use Mix.Task

  def run(args) do
    Mix.Task.run "app.start", args
    SseChatSimple.start
    unless (Code.ensure_loaded?(IEx) && IEx.started?) do
      :timer.sleep(:infinity)
    end
  end
end
