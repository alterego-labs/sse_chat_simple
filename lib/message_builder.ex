defmodule MessageBuilder do
  def build(qs_vals \\ []) do
    login = fetch_login(qs_vals)
    message = fetch_message(qs_vals)
    login <> ": " <> message
  end

  defp fetch_login([{"login", login} | _]) do
    login
  end

  defp fetch_login([_| tail]) do
    fetch_login tail
  end

  defp fetch_message([{"message", message} | _]) do
    message
  end

  defp fetch_message([_| tail]) do
    fetch_message tail
  end
end
