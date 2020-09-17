defmodule EctoJob.Web.PageLive do
  use EctoJob.Web, :live_view

  @pages %{
    "home" => EctoJob.Web.HomePage
  }

  def render(assigns) do
    ~L"""
    <main class="container-fluid">
      <%= render_page(@socket, @module, assigns) %>
    </main>
    """
  end

  def mount(%{"page" => page} = params, session, socket) do
    module = Map.get(@pages, page)

    socket =
      socket
      |> assign(:params, params)
      |> assign(:module, module)

    module.mount(params, session, socket)
  end

  def mount(params, session, socket) do
    params = Map.put(params, "page", "home")
    mount(params, session, socket)
  end

  defp render_page(_socket, module, assigns) do
    module.render(assigns)
  end
end
