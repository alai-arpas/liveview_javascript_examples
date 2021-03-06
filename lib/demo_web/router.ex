defmodule DemoWeb.Router do
  use DemoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DemoWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", DemoWeb do
    pipe_through :browser

    live "/", PageLive, :index
    live("/counter", CounterLive)
    live("/counter-via-hook", CounterViaHookLive)
    live "/counter-push-event", CounterPushEventLive
    live "/counter-shadow", CounterShadowAssignLive
    live "/counter-shadow-dom", CounterShadowAssignDomLive
    live "/counter-event-pub", CounterEventPubLive
    live "/counter-event-sub", CounterEventSubLive
    live "/counter-event-dispatch", CounterViaEventDispatchLive
    live "/counter-shadow-event", CounterShadowViaEventsLive
    live "/counter-subscribe", CounterSubscribeLive
    live "/counter-subscribe-pub", CounterSubscribePubLive
    live "/counter-subscribe-sub", CounterSubscribeSubLive
  end

  # Other scopes may use custom stacks.
  # scope "/api", DemoWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: DemoWeb.Telemetry
    end
  end
end
