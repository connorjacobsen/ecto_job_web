defmodule EctoJob.Web.HomePage do
  use EctoJob.Web, :live_view
  alias EctoJob.Web.Monitor

  def render(assigns) do
    ~L"""
    <table class="table">
      <thead class="thead-light">
        <tr>
          <th scope="col">ID</th>
          <th scope="col">State</th>
          <th scope="col">Params</th>
          <th scope="col">Expires</th>
          <th scope="col">Schedule</th>
          <th scope="col">Attempt</th>
          <th scope="col">Max Attempts</th>
          <th scope="col">Notify</th>
          <th scope="col">Inserted At</th>
          <th scope="col">Updated At</th>
        </tr>
      </thead>

      <tbody>
        <%= for job <- @jobs do %>
          <tr id="job-<%= job["id"] %>">
            <th scope="row"><%= job["id"] %></th>
            <td><%= job["state"] %></td>
            <td class="text-truncate" style="max-width: 500px"><%= inspect job["params"] %></td>
            <td><%= job["expires"] %></td>
            <td><%= job["schedule"] %></td>
            <td><%= job["attempt"] %></td>
            <td><%= job["max_attempts"] %></td>
            <td><%= job["notify"] %></td>
            <td><%= job["inserted_at"] %></td>
            <td><%= job["updated_at"] %></td>
          </tr>
        <% end %>
      </tbody>
    </table>
    """
  end

  # TODO: live updates
  def mount(_params, _session, socket) do
    jobs = Monitor.list_jobs(Monitor)

    {:ok, assign(socket, :jobs, jobs)}
  end
end
