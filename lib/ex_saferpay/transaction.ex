defmodule ExSaferpay.Transaction do
  @moduledoc """
  Transaction API Calls

  See http://saferpay.github.io/jsonapi/1.2/#ChapterTransaction
  """

  require ExSaferpay
  alias ExSaferpay.Request
  alias ExSaferpay.Response

  @doc """
  See http://saferpay.github.io/jsonapi/1.2/#Payment_v1_Transaction_Initialize
  """
  @initialize_response Response.TransactionInitialize.empty()
  ExSaferpay.defrequest(
    initialize(transaction_initialize),
    url: "/Payment/v1/Transaction/Initialize",
    in: Request.TransactionInitialize,
    out: :initialize_response
  )

  @doc """
  See http://saferpay.github.io/jsonapi/#Payment_v1_Transaction_AuthorizeDirect
  """
  @authorize_direct_response Response.TransactionAuthorizeDirect.empty()
  ExSaferpay.defrequest(
    authorize_direct(transaction_authorize_direct),
    url: "/Payment/v1/Transaction/AuthorizeDirect",
    in: Request.TransactionAuthorizeDirect,
    out: :authorize_direct_response
  )

  @doc """
  See http://saferpay.github.io/jsonapi/#Payment_v1_Transaction_AuthorizeReferenced
  """
  @authorize_referenced_response Response.TransactionAuthorizeReferenced.empty()
  ExSaferpay.defrequest(
    authorize_referenced(transaction_authorize_referenced),
    url: "/Payment/v1/Transaction/AuthorizeReferenced",
    in: Request.TransactionAuthorizeReferenced,
    out: :authorize_referenced_response
  )

  @doc """
  See http://saferpay.github.io/jsonapi/#Payment_v1_Transaction_Capture
  """
  @capture_response Response.TransactionCapture.empty()
  ExSaferpay.defrequest(
    capture(transaction_capture),
    url: "/Payment/v1/Transaction/Capture",
    in: Request.TransactionCapture,
    out: :capture_response
  )

  @doc """
  See http://saferpay.github.io/jsonapi/#Payment_v1_Transaction_Authorize
  """
  @authorize_response Response.TransactionAuthorize.empty()
  ExSaferpay.defrequest(
    authorize(transaction_authorize),
    url: "/Payment/v1/Transaction/Authorize",
    in: Request.TransactionAuthorize,
    out: :authorize_response
  )
end
