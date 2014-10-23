defmodule Handlers.PushMessage do
  @behaviour :cowboy_http_handler

  def init(_transport, req, _opts) do
    {:ok, req, {}}
  end

  def handle(req, state) do
    message = make_message(req)
    IO.puts "Sending message: " <> message
    clients = :pg2.get_members(:pongers)
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

  defp make_message(req) do
    login_msg(req) <> ": " <> message_msg(req)
  end

  defp login_msg(req) do
    {login, _req} = :cowboy_req.qs_val(<<"login">>, req)
    login
  end

  defp message_msg(req) do
    {message, _req} = :cowboy_req.qs_val(<<"message">>, req)
    message
  end
end
