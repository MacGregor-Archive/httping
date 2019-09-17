defmodule LiveViewDemoWeb.PingLive do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <h1 class="text-3xl font-bold">httping</h1>
    <div>
      <h2 phx-click="boom">It's <%= @date %></h2>
    </div>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: :timer.send_interval(1000, self(), :tick)

    {:ok, put_date(socket)}
  end

  def handle_info(:tick, socket) do
    {:noreply, put_date(socket)}
  end

  defp put_date(socket) do
    assign(socket, date: DateTime.utc_now())
  end
end
