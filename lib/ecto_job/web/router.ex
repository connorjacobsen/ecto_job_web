defmodule EctoJob.Web.Router do
  @moduledoc """
  Provides LiveView routing for EctoJob.Web
  """

  defmacro ecto_job_dashboard(path, opts \\ []) do
    quote bind_quoted: binding() do
      scope path, alias: false, as: false do
        import Phoenix.LiveView.Router, only: [live: 4]

        opts = EctoJob.Web.Router.__options__(opts)
        live("/", EctoJob.Web.PageLive, :home, opts ++ [page: "home"])

        # Catch-all
        live("/:page", EctoJob.Web.PageLive, :page, opts)
      end
    end
  end

  @doc false
  def __options__(options) do
    live_socket_path = Keyword.get(options, :live_socket_path, "/live")

    [
      private: %{live_socket_path: live_socket_path},
      layout: {EctoJob.Web.LayoutView, :dashboard},
      as: :ecto_job_web
    ]
  end
end
