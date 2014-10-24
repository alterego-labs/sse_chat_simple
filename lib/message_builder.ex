defmodule MessageBuilder do
  use Timex

  def build(qs_vals \\ []) do
    list = [] |> apply_login(qs_vals) |> apply_message(qs_vals) |> apply_datetime
    {:ok, message} = JSEX.encode list
    message
  end

  defp apply_login(list, qs_vals) do
    [{:username, fetch_login(qs_vals)} | list]
  end

  defp apply_message(list, qs_vals) do
    [{:message, fetch_message(qs_vals)} | list]
  end

  defp apply_datetime(list) do
    [{:datetime, datetime} | list]
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

  defp datetime do
    date = Date.local
    DateFormat.format!(date, "%a, %d %m %Y %T", :strftime)
  end
end
