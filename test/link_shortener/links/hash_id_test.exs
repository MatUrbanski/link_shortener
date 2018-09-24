defmodule LinkShortener.HashIdTest do
  use LinkShortener.DataCase

  alias LinkShortener.HashId

  describe "type/0" do
    test "it returns :string" do
      assert HashId.type == :string
    end
  end

  describe "cast/1" do
    test "it returns {:ok, value} when passed value is binary" do
      cast = HashId.cast("test")

      assert cast == {:ok, "test"}
    end

    test "it returns {:error, 123 is not a string} when passed value is not binary" do
      cast = HashId.cast(123)

      assert cast == {:error, "123 is not a string"}
    end
  end

  describe "dump/1" do
    test "it returns {:ok, value} when passed value is binary" do
      dump = HashId.dump("test")

      assert dump == {:ok, "test"}
    end

    test "it returns {:error, 123 is not a string} when passed value is not binary" do
      dump = HashId.dump(123)

      assert dump == {:error, "123 is not a string"}
    end
  end

  describe "load/1" do
    test "it returns {:ok, value} when passed value is binary" do
      load = HashId.dump("test")

      assert load == {:ok, "test"}
    end

    test "it returns {:error, 123 is not a string} when passed value is not binary" do
      load = HashId.load(123)

      assert load == {:error, "123 is not a string"}
    end
  end

  describe "autogenerate/0" do
    test "it generates unique hash_id" do
      hash_id = HashId.autogenerate

      assert String.length(hash_id) == 10
    end
  end
end
