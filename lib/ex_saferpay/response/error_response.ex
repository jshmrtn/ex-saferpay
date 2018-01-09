defmodule ExSaferpay.Response.ErrorResponse do
  @moduledoc """
  Base Error
  """

  alias ExSaferpay.Response

  @type t :: %__MODULE__{
    response_header: Response.ResponseHeader.t,
    behavior: atom,
    error_name: String.t,
    error_message: String.t,
    transaction_id: nil | String.t,
    error_detail: [String.t],
    processor_name: nil | String.t,
    processor_result: nil | String.t,
    processor_message: nil | String.t,
  }

  defstruct [
    :response_header,
    :behavior,
    :error_name,
    :error_message,
    :transaction_id,
    :error_detail,
    :processor_name,
    :processor_result,
    :processor_message,
  ]

  def empty do
    %__MODULE__{
      response_header: Response.ResponseHeader.empty(),
      behavior: :atom,
      error_name: :atom,
    }
  end
end
