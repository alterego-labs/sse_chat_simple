defmodule Handlers.Index do
  @behaviour :cowboy_http_handler

  def init(_, req, _) do
    IO.puts "Init Index handler..."
    {:ok, req, :no_state}
  end

  def handle(req, state) do
    IO.puts "Index handling..."
    {:ok, data} = File.read "assets/index.html"
    {ok, req} = :cowboy_req.reply(200, [{"content-type", "text/html"}], data, req)
    {ok, req, state}
  end

  def terminate(_request, _state, _) do
    :ok
  end
end
