defmodule ExSaferpay.Response.CheckResult do
  @moduledoc """
  See `CheckResult` http://saferpay.github.io/jsonapi/1.2/
  """

  @type t :: %__MODULE__{
    result: String.t,
    message: String.t,
  }

  defstruct [
    :result,
    :message,
  ]

  def empty do
    %__MODULE__{}
  end
end
