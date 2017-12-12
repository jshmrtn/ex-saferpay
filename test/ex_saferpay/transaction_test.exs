defmodule ExSaferpay.TransactionTest do
  @moduledoc false

  use ExSaferpay.ResponseMockCase
  alias ExSaferpay.{Request, Response, ResponseMockCase, SecureAliasStore, Transaction}
  doctest Transaction

  describe "initialize/1" do
    @tag response_mocks: %{
      {:post, "/Payment/v1/Transaction/Initialize"} => "L-O9IQmOSW9zqUsIqPQICw",
    }
    test "works", %{response_mocks: response_mocks} do
      with_response_mocks response_mocks do
        request = Request.TransactionInitialize.generate(%{
          payment: %Request.Payment{
            amount: Money.new(500, :USD),
          },
          return_urls: %Request.ReturnUrls{
            success: URI.parse("https://foo.ch"),
            fail: URI.parse("https://foo.ch"),
          },
        })

        assert {:ok, %Response.TransactionInitialize{}} = Transaction.initialize(request)
      end
    end

    @tag response_mocks: %{
      {:post, "/Payment/v1/Transaction/Initialize"} => "kCO8m9RvyKCsTr2H6ZCAZw",
    }
    test "works with alias", %{response_mocks: response_mocks} do
      with_response_mocks response_mocks do
        request = Request.TransactionInitialize.generate(%{
          payment: %Request.Payment{
            amount: Money.new(500, :USD),
          },
          payment_means: %Request.PaymentMeans{
            alias: %Request.Alias{
              id: "7d3eef510ef7c5f2e6311a402ef85b20",
              verification_code: "123",
            },
          },
          return_urls: %Request.ReturnUrls{
            success: URI.parse("https://foo.ch"),
            fail: URI.parse("https://foo.ch"),
          },
        })

        assert {:ok, %{}} = Transaction.initialize(request)
      end
    end

    @tag response_mocks: %{
      {:post, "/Payment/v1/Transaction/Initialize"} => "-r6S8KLSobMTgENp1iZ_5A",
    }
    test "gives correct error", %{response_mocks: response_mocks} do
      with_response_mocks response_mocks do
        request = Request.TransactionInitialize.generate(%{
          payment: "invalid request",
          payment_means: "invalid request",
          return_urls: "invalid request",
        })

        assert {:error,
         {400, %ExSaferpay.Response.ErrorResponse{behavior: :abort,
          error_detail: ["ReturnUrls: The ReturnUrls field is required.",
           "Payment: The Payment field is required."],
          error_message: "Request validation failed",
          error_name: :validation_failed, processor_message: nil,
          processor_name: nil, processor_result: nil,
          response_header: %ExSaferpay.Response.ResponseHeader{request_id: "43d3b46c-8eb2-4a1f-86cf-b2ee097f7a79",
           spec_version: "1.8"}, transaction_id: nil}}} = Transaction.initialize(request)
      end
    end
  end

  describe "authorize_direct/1" do

    @tag response_mocks: %{
      {:post, "/Payment/v1/Transaction/AuthorizeDirect"} => "sXdyGCl3sPS1mDgy0JLvBA",
    }
    test "works with alias", %{response_mocks: response_mocks} do
      with_response_mocks response_mocks do
        request = Request.TransactionAuthorizeDirect.generate(%{
          payment: %Request.Payment{
            amount: Money.new(500, :USD),
          },
          payment_means: %Request.PaymentMeans{
            alias: %Request.Alias{
              id: "7d3eef510ef7c5f2e6311a402ef85b20",
              verification_code: "123",
            },
          },
        })

        assert {:ok, %Response.TransactionAuthorizeDirect{}} = Transaction.authorize_direct(request)
      end
    end
  end

  describe "capture/1" do
    setup do
      response_mocks = ResponseMockCase.get_mocks(%{
        {:post, "/Payment/v1/Transaction/AuthorizeDirect"} => "yEKgNyMvCzKqhu8ByR9TqA",
      })
      with_response_mocks response_mocks do
        request = Request.TransactionAuthorizeDirect.generate(%{
          payment: %Request.Payment{
            amount: Money.new(500, :USD),
          },
          payment_means: %Request.PaymentMeans{
            alias: %Request.Alias{
              id: "7d3eef510ef7c5f2e6311a402ef85b20",
              verification_code: "123",
            },
          },
        })

        {:ok, %Response.TransactionAuthorizeDirect{} = authorization} = Transaction.authorize_direct(request)

        {:ok, %{authorization: authorization}}
      end
    end
    @tag response_mocks: %{
      {:post, "/Payment/v1/Transaction/Capture"} => "1iQ6dESDZztMhD5sZMaL8g",
    }
    test "works with alias", %{response_mocks: response_mocks, authorization: %{transaction: %{id: transaction_id}}} do
      with_response_mocks response_mocks do
        request = Request.TransactionCapture.generate(%{
          amount: Money.new(500, :USD),
          transaction_reference: %Request.TransactionReference{
            transaction_id: transaction_id,
          },
        })

        assert {:ok, %Response.TransactionCapture{}} = Transaction.capture(request)
      end
    end
  end

  describe "authorize/1" do
    setup do
      Process.put(:mock_server, true)
      response_mocks = ResponseMockCase.get_mocks(%{
        {:post, "/Payment/v1/Alias/InsertDirect"} => "V8ZAT1B4Bh7MJfbRQ5fCiw",
        {:post, "/Payment/v1/Transaction/Initialize"} => "vYC3z3o5azkKmTJz__BDwg",
      })
      with_response_mocks response_mocks do
        request = Request.AliasInsertDirect.generate(%{
          register_alias: %Request.RegisterAlias{
            id_generator: :random_unique
          },
          payment_means: %Request.PaymentMeans{
            card: %Request.Card{
              number: "9010101052000002", # 3D Secure disabled
              exp_year: 2037,
              exp_month: 7,
            },
          },
        })

        {:ok, %Response.AliasInsertDirect{} = alias_insert_direct} = SecureAliasStore.insert_direct(request)

        request = Request.TransactionInitialize.generate(%{
          payment: %Request.Payment{
            amount: Money.new(500, :USD),
          },
          payment_means: %Request.PaymentMeans{
            alias: %Request.Alias{
              id: alias_insert_direct.alias.id,
              verification_code: "123",
            }
          },
          return_urls: %Request.ReturnUrls{
            success: URI.parse("https://foo.ch"),
            fail: URI.parse("https://foo.ch"),
          },
        })

        {:ok, %Response.TransactionInitialize{} = initialization} = Transaction.initialize(request)

        {:ok, %{initialization: initialization}}
      end
    end
    @tag response_mocks: %{
      {:post, "/Payment/v1/Transaction/Authorize"} => "sQZmepLpGfvTWIijEGEs3A",
    }
    test "works with alias", %{response_mocks: response_mocks, initialization: %{token: token}} do
      with_response_mocks response_mocks do
        request = Request.TransactionAuthorize.generate(%{
          verification_code: "123",
          token: token,
        })

        assert {:ok, %Response.TransactionAuthorize{}} = Transaction.authorize(request)
      end
    end
  end
end
