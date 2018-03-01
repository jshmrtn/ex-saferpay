defmodule ExSaferpay.RequestNormalizer do
  @moduledoc false

  defp camelize_map(map) do
    Enum.map(map, fn
      {key, value} when is_binary(key) ->
        {Macro.camelize(key), value}

      {key, value} when is_atom(key) ->
        {Macro.camelize(Atom.to_string(key)), value}
    end)
  end

  defp normalize_values(map) do
    Enum.map(map, fn
      {key, %Money{amount: amount, currency: currency}} ->
        amount =
          amount
          |> Decimal.mult(Decimal.new(100))
          |> Decimal.to_integer()

        {key,
         %{
           Value: amount,
           CurrencyCode: currency
         }}

      {key, %URI{} = uri} ->
        {key, URI.to_string(uri)}

      other ->
        other
    end)
  end

  def json_encode(map, options) do
    map
    |> Map.from_struct()
    |> camelize_map
    |> normalize_values
    |> Enum.into(%{})
    |> Poison.encode!(options)
  end

  defmacro __using__(_) do
    quote do
      defimpl Poison.Encoder, for: __MODULE__ do
        defdelegate encode(map, options), to: ExSaferpay.RequestNormalizer, as: :json_encode
      end
    end
  end
end
