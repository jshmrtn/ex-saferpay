defmodule ExSaferpay.ResponseNormalizer do
  @moduledoc false

  require Logger

  def transform(nil, _), do: nil
  def transform(%{} = input, %{__struct__: _} = as) do
    as
    |> Map.from_struct
    |> Enum.reduce(as, fn
      {key, %{__struct__: _} = value}, acc ->
        Map.put(acc, key, transform(value(input, key), value))
      {key, value}, acc when is_atom(value) ->
        Map.put(acc, key, transform(value(input, key), value))
      {key, _}, acc ->
        Map.put(acc, key, transform(value(input, key), nil))
    end)
  end
  def transform(input, DateTime) do
    case DateTime.from_iso8601(input) do
      {:ok, date, _} -> date
      {:error, error} ->
        Logger.warn("Invalid DateTime value #{inspect input}. Error: #{inspect error}")
        nil
    end
  end
  def transform(input, URI), do: URI.parse(input)
  def transform(input, :atom), do: String.to_atom(input)
  def transform(input, _), do: input

  defp value(input = %{}, key) when is_atom(key) do
    cond do
      input[key] -> input[key]
      input[Atom.to_string(key)] -> input[Atom.to_string(key)]
      input[String.to_atom(camelize(key))] -> input[String.to_atom(camelize(key))]
      input[camelize(key)] -> input[camelize(key)]
      true -> nil
    end
  end

  defp camelize(name) when is_atom(name) do
    Macro.camelize(Atom.to_string(name))
  end
end
