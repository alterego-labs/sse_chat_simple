defmodule Handlers.Index do
  @behaviour :cowboy_http_handler

  def init(_, req, _) do
    IO.puts "status handler init"
    {:ok, req, :no_state}
  end

  def handle(req, state) do
    IO.puts "status handler"
    {ok, req} = :cowboy_req.reply(200, [{"content-type", "text/html"}], "Answer", req)
    {ok, req, state}
  end

  def terminate(_request, _state, _) do
    :ok
  end
end
