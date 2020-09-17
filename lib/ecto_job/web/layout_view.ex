defmodule EctoJob.Web.LayoutView do
  @moduledoc false
  use EctoJob.Web, :view

  def live_socket_path(conn) do
    [Enum.map(conn.script_name, &["/" | &1]) | conn.private.live_socket_path]
  end
end
