defmodule SuperTiger.Repo do
  use Ecto.Repo, otp_app: :super_tiger
  use Scrivener, page_size: 10  # <--- add this
end
