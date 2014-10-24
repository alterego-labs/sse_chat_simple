defmodule Handlers.PushMessage do
  @behaviour :cowboy_http_handler

  def init(_transport, req, _opts) do
    {:ok, req, {}}
  end

  def handle(req, state) do
    {qs_vals, _req} = :cowboy_req.qs_vals(req)
    message = MessageBuilder.build qs_vals
    IO.puts "Sending message: " <> message
    clients = ClientsRepository.members
    Enum.each clients, &notify_clients(&1, message)
    :cowboy_req.reply 200, [], <<"ack">>, req
    {:ok, req, state}
  end

  def notify_clients(pid, msg) do
    :lasse_handler.notify pid, {:message, msg}
  end

  def info(_msg, req, state) do
    {:ok, req, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
