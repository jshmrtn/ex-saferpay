defmodule ExSaferpay do
  @moduledoc """
  HTTPoison Wrapper for Saferpay JSON API 1.2

  Adds needed headers, authorizaion and response handling.

  This module should not be used directly.

  See `HTTPoison.Base`
  """

  use HTTPoison.Base
  alias HTTPoison.Response
  alias ExSaferpay.ResponseNormalizer

  @saferpay_baseurls %{
    test: "https://test.saferpay.com/api",
    prod: "https://www.saferpay.com/api",
  }
  @spec_version "1.8"

  def spec_version, do: @spec_version

  def process_url("/" <> url) do
    process_url(url)
  end
  def process_url(url)
  when is_binary(url) do
    @saferpay_baseurls
    |> Map.fetch!(Application.get_env(:ex_saferpay, :environment, :test))
    |> Kernel.<>("/")
    |> Kernel.<>(url)
  end

  def process_request_body(body)
  when is_binary(body) do
    body
  end
  def process_request_body(%{} = body) do
    body
    |> Poison.encode!()
  end

  def process_request_headers(headers)
  when is_list(headers) do
    headers = headers
    |> put_new_header("accept", "application/json")
    |> put_new_header("content-type", "application/json; charset=utf-8")

    case Application.get_env(:ex_saferpay, :authentication_method, :credentials) do
      :credentials ->
        add_auth_header(headers)
      :client_ssl ->
        headers
    end
  end

  def process_request_options(options)
  when is_list(options) do
    case Application.get_env(:ex_saferpay, :authentication_method, :credentials) do
      :credentials ->
        options
      :client_ssl ->
        client_ssl_options(options)
    end
  end

  defp client_ssl_options(options) do
    if options[:ssl][:cert] && options[:ssl][:key] do
      options
    else
      options
      |> Keyword.put_new(:ssl, [])
      |> put_in([:ssl, :cert], get_cert_der())
      |> put_in([:ssl, :key], get_key_der())
    end
  end

  defp get_cert_der do
    {cert_type, cert_entry} =
    :ex_saferpay
    |> Application.fetch_env!(:client_certificate)
    |> get_cert_der
    |> decode_pem_bin()
    |> decode_pem_entry()
    |> split_type_and_entry()

    encode_der(cert_type, cert_entry)
  end
  defp get_cert_der({:file, path})
  when is_binary(path) do
    File.read!(path)
  end

  defp get_key_der do
    {key_type, key_entry} =
      :ex_saferpay
      |> Application.fetch_env!(:client_key)
      |> get_key_der
      |> decode_pem_bin()
      |> decode_pem_entry()
      |> split_type_and_entry()

    {key_type, encode_der(key_type, key_entry)}
  end
  defp get_key_der({:file, path})
  when is_binary(path) do
    File.read!(path)
  end

  defp decode_pem_bin(pem_bin)
  when is_binary(pem_bin) do
    pem_bin |> :public_key.pem_decode() |> hd()
  end

  defp decode_pem_entry(pem_entry) do
    :public_key.pem_entry_decode(pem_entry)
  end

  defp encode_der(ans1_type, ans1_entity) do
    :public_key.der_encode(ans1_type, ans1_entity)
  end

  defp split_type_and_entry(ans1_entry) do
    ans1_type = elem(ans1_entry, 0)
    {ans1_type, ans1_entry}
  end

  defp header_exists?(headers, needle)
  when is_list(headers) and is_binary(needle)
  do
    Enum.find(headers, fn
      {^needle, _} -> true
      _ -> false
    end) != nil
  end

  defp put_new_header(headers, name, value) do
    if header_exists?(headers, name) do
      headers
    else
      [{name, value} | headers]
    end
  end

  defp add_auth_header(headers) do
    with username = Application.fetch_env!(:ex_saferpay, :username),
      password = Application.fetch_env!(:ex_saferpay, :password),
      token = Base.encode64(username <> ":" <> password),
      value = "Basic " <> token
    do
      put_new_header(headers, "authorization", value)
    end
  end

  def decode_response(%Response{body: body} = response, nil) do
    if is_json_response(response) do
      case Poison.decode(body) do
        {:ok, decoded} ->
          {:ok, %{response | body: decoded}}
        {:error, error} ->
          {:error, error}
      end
    else
      response
    end
  end
  def decode_response(response, as) do
    case decode_response(response, nil) do
      {:ok, %Response{body: body, status_code: 200} = response} ->
        {:ok, %{response | body: ResponseNormalizer.transform(body, as)}}
      other ->
        other
    end
  end

  defp is_json_response(%Response{headers: headers}) do
    Enum.any?(headers, fn
      {"Content-Type", content} ->
        content =~ "application/json"
      _ ->
        false
    end)
  end

  case Mix.env do
    :test ->
      def save_mock(request) do
        if Process.get(:mock_server, false) do
          ExSaferpay.MockServer.dump(request)
        else
          request
        end
      end
    _ ->
      def save_mock(request), do: request
  end

  defmacro defrequest(funs, opts) do
    funs = Macro.escape(funs, unquote: true)

    quote bind_quoted: [funs: funs, opts: opts] do
      for fun <- List.wrap(funs) do
        {name, args} = Macro.decompose_call(fun)

        if !Keyword.has_key?(opts, :url) do
          raise ArgumentError, "expected url: to be given as argument"
        end

        if !Keyword.has_key?(opts, :in) do
          raise ArgumentError, "expected in: to be given as argument"
        end

        if Keyword.has_key?(opts, :out) do
          @out Module.get_attribute(__MODULE__, opts[:out])
        else
          @out nil
        end

        def unquote(name)(unquote_splicing(args)) do
          unquote(opts)
          |> Keyword.fetch!(:url)
          |> ExSaferpay.post(unquote_splicing(args))
          |> ExSaferpay.save_mock
          |> case do
            {:ok, response} ->
              ExSaferpay.decode_response(response, @out)
            {:error, error} ->
              {:error, error}
          end
        end
      end
    end
  end
end
