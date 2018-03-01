defmodule ExSaferpay.Response.AliasDelete do
  @moduledoc """
  See `AliasDelete` http://saferpay.github.io/jsonapi/1.2/
  """

  alias ExSaferpay.Response

  @type t :: %__MODULE__{
          response_header: Response.ResponseHeader.t()
        }

  defstruct [
    :response_header
  ]

  def empty do
    %__MODULE__{
      response_header: Response.ResponseHeader.empty()
    }
  end
end
