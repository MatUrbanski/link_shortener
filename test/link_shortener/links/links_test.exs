defmodule LinkShortener.LinksTest do
  use LinkShortener.DataCase

  alias LinkShortener.Links
  alias LinkShortener.Links.Link

  describe "list_links/0" do
    test "returns all links when links are present" do
      link = create(:link)

      assert Links.list_links() == [link]
    end

    test "returns empty collection when links are not present" do
      assert Links.list_links() == []
    end
  end

  describe "get_link!/1" do
    test "it returns link when id is valid" do
      link = create(:link)
      finded_link = Links.get_link!(link.hash)

      assert finded_link == link
    end

    test "it raise error when id is not valid" do
      assert_raise Ecto.NoResultsError, fn -> Links.get_link!("test") end
    end
  end

  describe "create_link/1" do
    test "with valid data it creates a link" do
      link = create(:link)

      assert String.length(link.hash) == 10
      assert link.url == "http://localhost:3000"
    end

    test "with invalid data it not creates a link" do
      assert {:error, %Ecto.Changeset{}} = Links.create_link(%{})
    end
  end

  describe "update_link/2" do
    test "with valid data it updates link" do
      link = create(:link)

      assert {:ok, link} = Links.update_link(link, %{url: "http://localhost:4000"})
      assert %Link{} = link
      assert link.url == "http://localhost:4000"
    end

    test "with invalid data returns error changeset" do
      link = create(:link)

      assert {:error, %Ecto.Changeset{}} = Links.update_link(link, %{url: ""})
    end
  end

  describe "delete/1" do
    test "deletes the link when link is present" do
      link = create(:link)

      assert {:ok, %Link{}} = Links.delete_link(link)
      assert_raise Ecto.NoResultsError, fn -> Links.get_link!(link.hash) end
    end

    test "raise error when link is not present" do
      assert_raise Ecto.StaleEntryError, fn -> Links.delete_link(%Link{hash: "test"}) end
    end
  end

  describe "change_link/1" do
    test "it returns errors when urls is blank" do
      changeset = Links.change_link(%Link{})

      assert changeset.errors == [url: {"can't be blank", [validation: :required]}]
    end

    test "it not returns errors when urls is present" do
      changeset = Links.change_link(%Link{url: 'http://localhost:3000'})

      assert changeset.errors == []
    end
  end
end
