defmodule DemoWeb.CounterLive do
  use DemoWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, count: 0)}
  end

  def handle_event("increment", _params, socket) do
    {:noreply, update(socket, :count, &(&1 + 1))}
  end

  def handle_event("decrement", _params, socket) do
    {:noreply, update(socket, :count, &(&1 - 1))}
  end

  def render(assigns) do
    ~L"""
    <div id="counter">
    <h1>The count is: <span><%= @count %></span></h1>
    <button phx-click="decrement"> Decrement </button>
    <button phx-click="increment"> Increment </button>
    </div>
    """
  end
end
