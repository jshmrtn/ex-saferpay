defmodule Mix.Tasks.ExSaferpay.SaveMock do
  @moduledoc false

  use Mix.Task

  @shortdoc "Save Mock Response"
  @preferred_cli_env :test

  case Mix.env() do
    :test ->
      def run([id]) do
        ExSaferpay.MockServer.save(id)
      end

    _ ->
      def run(_) do
        IO.puts("Run task with Env test")
      end
  end
end
