defmodule ExSaferpay.ResponseMockCase do
  @moduledoc """
  This module defines the test case to be used by
  response mock tests.
  """

  use ExUnit.CaseTemplate
  alias ExSaferpay.MockServer

  using do
    quote do
      import Mock
      alias ExSaferpay.HTTPClient

      defmacro with_response_mocks(mocks, do: test_block) do
        quote do
          Mock.with_mock HTTPoison.Base, [:passthrough], unquote(mocks), do: unquote(test_block)
        end
      end
    end
  end

  setup tags do
    responses = tags
    |> Map.get(:response_mocks, [])
    |> Enum.map(fn {clause, id} ->
      {clause, MockServer.get(id)}
    end)
    |> Enum.reduce(%{}, fn {{method, url}, response}, acc ->
      url = clean_url(url)
      Map.update(acc, method, %{url => response}, fn method_responses ->
        Map.put(method_responses, url, response)
      end)
    end)

    response_mocks = [
      request: fn(_, method, url, _, _, _, _, _, _) ->
        url = clean_url(url)
        case responses[method][url] do
          nil ->
            {:error, "Mock for #{inspect method} #{url} not defined"}
          response ->
            response
        end
      end,
    ]

    reset_config()

    Process.put(:mock_server, true)

    on_exit fn ->
      Process.delete(:mock_server)
    end

    {:ok, %{response_mocks: response_mocks}}
  end

  defp clean_url("/" <> url), do: URI.parse(url).path
  defp clean_url("http" <> url) do
    url = clean_url(URI.parse(url).path)
    [_version, url] = String.split(url, "/", parts: 2)
    url
  end
  defp clean_url(url), do: URI.parse(url).path

  defp reset_config do
    Application.put_env(:ex_saferpay, :username, System.get_env("SAFERPAY_USERNAME") || raise "Set SAFERPAY_USERNAME!")
    Application.put_env(:ex_saferpay, :password, System.get_env("SAFERPAY_PASSWORD") || raise "Set SAFERPAY_PASSWORD!")
    Application.put_env(:ex_saferpay, :customer_id, System.get_env("SAFERPAY_CUSTOMER_ID") || raise "Set SAFERPAY_CUSTOMER_ID!")
    Application.put_env(:ex_saferpay, :terminal_id, System.get_env("SAFERPAY_TERMINAL_ID") || raise "Set SAFERPAY_TERMINAL_ID!")
  end
end
