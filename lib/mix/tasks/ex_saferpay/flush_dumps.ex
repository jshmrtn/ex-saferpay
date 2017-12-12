defmodule Mix.Tasks.ExSaferpay.FlushDumps do
  @moduledoc false

  use Mix.Task

  @shortdoc "Flush all Mock Dumps"
  @preferred_cli_env :test

  case Mix.env do
    :test ->
      def run(_) do
        ExSaferpay.MockServer.flush_dumps()
      end
    _ ->
      def run(_) do
        IO.puts "Run task with Env test"
      end
  end
end
