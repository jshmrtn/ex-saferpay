defmodule ExSaferpay.SecureAliasStoreTest do
  @moduledoc false

  use ExSaferpay.ResponseMockCase
  alias ExSaferpay.SecureAliasStore
  alias ExSaferpay.Request
  alias ExSaferpay.Response
  doctest SecureAliasStore

  describe "insert/1" do
    @tag response_mocks: %{
      {:post, "/Payment/v1/Alias/Insert"} => "93V8ReMhb-YDvV1au-WXxA",
    }
    test "works", %{response_mocks: response_mocks} do
      with_response_mocks response_mocks do
        request = Request.AliasInsert.generate(%{
          register_alias: %Request.RegisterAlias{
            id_generator: :random_unique
          },
          type: :card,
          return_urls: %Request.ReturnUrls{
            success: URI.parse("https://foo.ch"),
            fail: URI.parse("https://foo.ch"),
          },
        })

        assert {:ok, %Response.AliasInsert{}} = SecureAliasStore.insert(request)
      end
    end
  end

  describe "insert_direct/1" do
    @tag response_mocks: %{
      {:post, "/Payment/v1/Alias/InsertDirect"} => "aE4mXAzJB_F5giVXHWEqNw",
    }
    test "works", %{response_mocks: response_mocks} do
      with_response_mocks response_mocks do
        request = Request.AliasInsertDirect.generate(%{
          register_alias: %Request.RegisterAlias{
            id_generator: :random_unique
          },
          payment_means: %Request.PaymentMeans{
            card: %Request.Card{
              number: "9030100052000000",
              exp_year: 2037,
              exp_month: 7,
            },
          },
        })

        assert {:ok, %Response.AliasInsertDirect{}} = SecureAliasStore.insert_direct(request)
      end
    end
  end

  describe "delete/1" do
    @tag response_mocks: %{
      {:post, "/Payment/v1/Alias/Delete"} => "rp2yjfWpaBmuj7d-3K8kJw",
    }
    test "works", %{response_mocks: response_mocks} do
      with_response_mocks response_mocks do
        request = Request.AliasDelete.generate(%{
          alias_id: "7",
        })

        assert {:ok, %Response.AliasDelete{}} = SecureAliasStore.delete(request)
      end
    end
  end
end
