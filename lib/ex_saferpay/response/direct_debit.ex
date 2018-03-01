defmodule ExSaferpay.Response.DirectDebit do
  @moduledoc """
  See `DirectDebit` http://saferpay.github.io/jsonapi/1.2/
  """

  @type t :: %__MODULE__{
          mandate_id: String.t(),
          creditor_id: String.t()
        }

  defstruct [
    :mandate_id,
    :creditor_id
  ]

  def empty do
    %__MODULE__{}
  end
end
