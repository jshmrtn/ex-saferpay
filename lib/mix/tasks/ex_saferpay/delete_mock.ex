defmodule Mix.Tasks.ExSaferpay.DeleteMock do
  @moduledoc false

  use Mix.Task

  @shortdoc "Delete Mock Response"
  @preferred_cli_env :test

  case Mix.env() do
    :test ->
      def run([id]) do
        ExSaferpay.MockServer.delete(id)
      end

    _ ->
      def run(_) do
        IO.puts("Run task with Env test")
      end
  end
end
