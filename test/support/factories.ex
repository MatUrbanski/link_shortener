defmodule LinkShortener.Factories do
  alias LinkShortener.Repo
  alias LinkShortener.Links.Link

  # Factories
  def build(:link) do
    %Link{url: "http://localhost:3000"}
  end

  # Convenience API
  def build(factory_name, attributes) do
    factory_name |> build() |> struct(attributes)
  end

  def create(factory_name, attributes \\ []) do
    Repo.insert! build(factory_name, attributes)
  end
end
