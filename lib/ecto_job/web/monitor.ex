defmodule EctoJob.Web.Monitor do
  use GenServer
  import Ecto.Query, only: [from: 2]

  @topic inspect(__MODULE__)

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, Keyword.put(opts, :name, __MODULE__))
  end

  def topic, do: @topic

  def list_jobs(server), do: GenServer.call(server, :list_jobs)

  def init(opts), do: {:ok, Map.new(opts)}

  def handle_call(:list_jobs, _from, %{schema: schema, repo: repo} = state) do
    query =
      from(job in schema,
        select: [
          "id",
          job.id,
          "state",
          job.state,
          "params",
          job.params,
          "expires",
          job.expires,
          "schedule",
          job.schedule,
          "attempt",
          job.attempt,
          "max_attempts",
          job.max_attempts,
          "notify",
          job.notify,
          "inserted_at",
          job.inserted_at,
          "updated_at",
          job.updated_at
        ],
        order_by: [desc: :updated_at],
        limit: 50
      )

    jobs =
      query
      |> repo.all()
      |> Enum.map(&to_job/1)

    {:reply, jobs, state}
  end

  defp to_job(data) do
    data
    |> Enum.chunk_every(2)
    |> Enum.map(fn [a, b] -> {a, b} end)
    |> Map.new()
  end
end
