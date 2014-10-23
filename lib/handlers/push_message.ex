defmodule Handlers.PushMessage do
  @behaviour :cowboy_http_handler

  def init(_transport, req, _opts) do
    {:ok, req, {}}
  end

  def handle(req, state) do
    for pid <- :pg2.get_members(:ponders), do: notify_clients(pid)
    :cowboy_req.reply 200, [], <<"ack">>, req
    {:ok, req, state}
  end

  def notify_clients(pid) do
    OI.puts "Notify " <> pid
  end

  def info(_msg, req, state) do
    {:ok, req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
