defmodule HTTPing.API do
  @moduledoc """
  API client to perform HTTP checks
  """
  use HTTPoison.Base

  def process_url(path) do
    endpoint() <> path
  end

  def process_response_body(body) do
    body |> Jason.decode!()
  end

  def process_request_options(options) do
    options ++ [recv_timeout: 15_000]
  end

  def get(url) do
    get!("/get", [], params: %{url: url}).body
  end

  def normalize_url(url) do
    get!("/url/normalize", [], params: %{url: url}).body
  end

  defp config do
    Application.get_env(:httping, HTTPing)
  end

  defp endpoint do
    config()[:api_endpoint]
  end
end
