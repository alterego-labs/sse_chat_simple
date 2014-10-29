defmodule SseChatSimple do
  use Application

  def start(_type \\ "", _args \\ []) do
    dispatch = :cowboy_router.compile([
      {:_, [
          {"/", :cowboy_static, {:file, "views/index.html"}},
          {"/push_message", Handlers.PushMessage, []},
          {"/stream", :lasse_handler, [Handlers.Stream]}
        ]},
      ])
    :cowboy.start_http :sse_chat_simple_listener, 100,
      [port: 8182],
      [env: [dispatch: dispatch]]

    SseChatSimpleSup.start_link
  end
end
