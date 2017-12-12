defmodule ExSaferpayTest do
  @moduledoc false

  use ExUnit.Case
  doctest ExSaferpay

  setup do
    Application.put_env(:ex_saferpay, :environment, :test)
    Application.put_env(:ex_saferpay, :client_key, {:file, "priv/test/client.key"})
    Application.put_env(:ex_saferpay, :client_certificate, {:file, "priv/test/client.pem"})
    Application.put_env(:ex_saferpay, :authentication_method, :credentials)
    Application.put_env(:ex_saferpay, :username, "test")
    Application.put_env(:ex_saferpay, :password, "test")
    Application.put_env(:ex_saferpay, :customer_id, 7)
    :ok
  end

  describe "process_url/1" do
    test "creates correct url" do
      assert ExSaferpay.process_url("foo") == "https://test.saferpay.com/api/foo"
    end

    test "creates correct url with trailing slash" do
      assert ExSaferpay.process_url("/foo") == "https://test.saferpay.com/api/foo"
    end
  end

  describe "process_request_options/1" do
    test "adds correct client ssl auth" do
      Application.put_env(:ex_saferpay, :authentication_method, :client_ssl)

      result = ExSaferpay.process_request_options([])

      assert {:RSAPrivateKey, _} = result[:ssl][:key]
      assert cert = result[:ssl][:cert]
      assert is_binary(cert)
    end

    test "skips existing config" do
      Application.put_env(:ex_saferpay, :authentication_method, :client_ssl)

      options = [ssl: [key: "foo", cert: "bar"]]

      assert options == ExSaferpay.process_request_options(options)
    end

    test "skips in credentials mode" do
      assert [] == ExSaferpay.process_request_options([])
    end
  end

  describe "process_request_headers/1" do
    test "adds correct headers" do
      headers = ExSaferpay.process_request_headers([])
      assert Enum.member?(headers, {"accept", "application/json"})
    end

    test "does not override header" do
      headers = ExSaferpay.process_request_headers([{"accept", "application/xml"}])
      refute Enum.member?(headers, {"accept", "application/json"})
    end

    test "does not create auth header in client_ssl mode" do
      Application.put_env(:ex_saferpay, :authentication_method, :client_ssl)
      assert headers = ExSaferpay.process_request_headers([])
      refute Enum.member?(headers, {"authorization", "Basic dGVzdDp0ZXN0"})
    end

    test "does create auth header in credentials mode" do
      assert [{"authorization", "Basic dGVzdDp0ZXN0"} | _] = ExSaferpay.process_request_headers([])
    end
  end

  describe "process_request_body/1" do
    test "skips strings" do
      assert "string" = ExSaferpay.process_request_body("string")
    end

    test "json encodes maps" do
      response = ExSaferpay.process_request_body(%{foo: :bar})
      assert %{"foo" => "bar"} = Poison.decode!(response)
    end
  end
end
