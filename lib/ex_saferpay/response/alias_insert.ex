defmodule ExSaferpay.Response.AliasInsert do
  @moduledoc """
  See `AliasInsert` http://saferpay.github.io/jsonapi/1.2/
  """

  alias ExSaferpay.Response

  @type t :: %__MODULE__{
    response_header: Response.ResponseHeader.t,
    token: String.t,
    expiration: String.t,
    redirect_url: String.t,
  }

  defstruct [
    :response_header,
    :token,
    :expiration,
    :redirect_url,
  ]

  def empty do
    %__MODULE__{
      response_header: Response.ResponseHeader.empty(),
      expiration: DateTime,
      redirect_url: URI,
    }
  end
end
