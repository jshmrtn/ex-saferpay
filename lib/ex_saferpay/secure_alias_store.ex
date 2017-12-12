defmodule ExSaferpay.SecureAliasStore do
  @moduledoc """
  See http://saferpay.github.io/jsonapi/#ChapterAliasStore
  """

  require ExSaferpay
  alias ExSaferpay.Request
  alias ExSaferpay.Response

  @insert_response Response.AliasInsert.empty
  ExSaferpay.defrequest insert(alias_insert),
    url: "/Payment/v1/Alias/Insert",
    in: Request.AliasInsert,
    out: :insert_response

  @insert_direct_response Response.AliasInsertDirect.empty
  ExSaferpay.defrequest insert_direct(alias_insert_direct),
    url: "/Payment/v1/Alias/InsertDirect",
    in: Request.AliasInsertDirect,
    out: :insert_direct_response

  @delete_response Response.AliasDelete.empty
  ExSaferpay.defrequest delete(alias_delete),
    url: "/Payment/v1/Alias/Delete",
    in: Request.AliasDelete,
    out: :delete_response
end
