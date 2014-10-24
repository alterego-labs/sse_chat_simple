defmodule Handlers.Stream do
  @behaviour :lasse_handler

  def init(_init_args, _last_event_id, req) do
    ClientsRepository.add self()
    {:ok, req, {}}
  end

  def handle_notify({:message, msg}, state) do
    {:send, [{:data, msg}], state}
  end

  def handle_info(_msg, state) do
    {:nosend, state}
  end

  def handle_error(_msg, _reason, state) do
    state
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
