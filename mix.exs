defmodule EctoJob.Web.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_job_web,
      version: "0.1.0",
      elixir: "~> 1.8",
      compilers: [:phoenix] ++ Mix.compilers(),
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      aliases: aliases()
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "cmd npm install --prefix assets"],
      dev: "run --no-halt dev.exs"
    ]
  end

  defp package do
    [
      maintainers: ["Connor Jacobsen"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/connorjacobsen/ecto_job_web"},
      files: ~w(lib priv LICENSE mix.exs README.md)
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_live_view, "~> 0.14.4"},
      {:phoenix_html, "~> 2.14.1 or ~> 2.15"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:plug_cowboy, "~> 2.0", only: :dev},
      {:ex_doc, "~> 0.21", only: :docs},
      {:ecto_sql, "~> 3.2"},
      {:postgrex, "~> 0.15", optional: true}
    ]
  end
end
