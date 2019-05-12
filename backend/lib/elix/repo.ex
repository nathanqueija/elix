defmodule Elix.Repo do
  use Ecto.Repo,
    otp_app: :elix,
    adapter: Ecto.Adapters.Postgres
end
