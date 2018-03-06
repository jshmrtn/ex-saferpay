defmodule ExSaferpay.Util do
  @moduledoc false

  def terminal_id do
    :ex_saferpay
    |> Application.fetch_env!(:terminal_id)
    |> normalize_integer
  end

  def customer_id do
    :ex_saferpay
    |> Application.fetch_env!(:customer_id)
    |> normalize_integer
  end

  def normalize_integer(id) when is_integer(id), do: id
  def normalize_integer(id) when is_binary(id), do: String.to_integer(id)
end
