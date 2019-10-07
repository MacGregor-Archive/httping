defmodule LiveViewDemoWeb.PingLive do
  use Phoenix.LiveView
  alias LiveViewDemoWeb.PingView
  alias LiveViewDemoWeb.Router.Helpers, as: Routes

  def render(assigns), do: PingView.render("dashboard.html", assigns)

  def mount(_session, socket) do
    {:ok, socket}
  end

  def handle_info(:check, %{assigns: %{url: nil}} = socket) do
    {:noreply, socket}
  end

  def handle_info(:check, socket) do
    IO.puts("Checking #{socket.assigns[:url]}")
    response = LiveViewDemo.API.get(socket.assigns[:url])
    if connected?(socket), do: :timer.send_after(10_000, self(), :check)
    {:noreply, socket |> assign(:response, response)}
  end

  def handle_event("validate", %{"check" => %{"url" => _url}}, socket) do
    {:noreply, socket}
  end

  def handle_event("save", %{"check" => %{"url" => url}}, socket) do
    {:noreply,
     live_redirect(socket, to: Routes.live_path(socket, LiveViewDemoWeb.PingLive, url: url))}
  end

  def handle_params(%{"url" => url}, _uri, socket) do
    :timer.send_after(100, self(), :check)
    {:noreply, assign(socket, :url, url)}
  end

  def handle_params(_, _, socket) do
    {:noreply, socket |> assign(:url, nil) |> assign(:response, nil)}
  end
end
