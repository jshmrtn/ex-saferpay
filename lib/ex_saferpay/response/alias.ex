defmodule ExSaferpay.Response.Alias do
  @moduledoc """
  See `Alias` http://saferpay.github.io/jsonapi/1.2/
  """

  @type t :: %__MODULE__{
          id: String.t(),
          lifetime: 1..1600
        }

  defstruct [
    :id,
    :lifetime
  ]

  def empty do
    %__MODULE__{}
  end
end
