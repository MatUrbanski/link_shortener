defmodule LinkShortener.Links.Link do
  use Ecto.Schema

  import Ecto.Changeset

  alias LinkShortener.HashId

  @primary_key {:hash, HashId, [autogenerate: true]}
  @derive {Phoenix.Param, key: :hash}

  schema "links" do
    field :url, :string

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:url])
    |> validate_required([:url])
  end
end
