defmodule SseChatSimple do
  use Application

  def start(_type \\ "", _args \\ []) do
    dispatch = :cowboy_router.compile([
      {:_, [
          {"/", Handlers.Index, []},
          {"/push_message", Handlers.PushMessage, []}
        ]},
      ])
    :cowboy.start_http :sse_chat_simple_listener, 100,
      [port: 8080],
      [env: [dispatch: dispatch]]
    SseChatSimpleSup.start_link
  end
end
