defmodule LinkShortener.HashId do
  @behaviour Ecto.Type
  @hash_id_length 10

  @doc "The Ecto type."
  def type, do: :string

  @doc "Called when creating an Ecto.Changeset"
  def cast(value) when is_binary(value), do: {:ok, value}
  def cast(value), do: {:error, "#{value} is not a string"}

  @doc "Converts/accepts a value that has been directly placed into the ecto struct after a changeset"
  def dump(value) when is_binary(value), do: {:ok, value}
  def dump(value), do: {:error, "#{value} is not a string"}

  @doc "Converts a value from the database into the HashId type"
  def load(value) when is_binary(value), do: {:ok, value}
  def load(value), do: {:error, "#{value} is not a string"}

  @doc "Callback invoked by autogenerate fields."
  def autogenerate do
    @hash_id_length
    |> :crypto.strong_rand_bytes()
    |> Base.url_encode64()
    |> binary_part(0, @hash_id_length)
  end
end
