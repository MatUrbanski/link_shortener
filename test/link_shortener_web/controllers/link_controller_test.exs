defmodule LinkShortenerWeb.LinkControllerTest do
  use LinkShortenerWeb.ConnCase

  alias LinkShortener.Repo
  alias LinkShortener.Links.Link

  setup do
    {:ok, conn: put_req_header(build_conn(), "accept", "application/json")}
  end

  describe "index/2" do
    test "returns empty array when there is no links", %{conn: conn} do
      conn = get conn, link_path(conn, :index)

      assert json_response(conn, 200)["data"] == []
    end

    test "returns json response with links data when there are links", %{conn: conn} do
      link = create(:link)
      conn = get conn, link_path(conn, :index)

      assert json_response(conn, 200)["data"] == [
        %{
          "id"  => link.hash,
          "url" => link.url
        }
      ]
    end
  end

  describe "show/2" do
    test "returns json respone with link data", %{conn: conn} do
      link = create(:link)
      conn = get conn, link_path(conn, :show, link.hash)

      assert json_response(conn, 200) == %{
        "id"  => link.hash,
        "url" => link.url
      }
    end

    test "renders error when id is invalid", %{conn: conn} do
      response = assert_error_sent :not_found, fn ->
        get conn, link_path(conn, :show, "test")
      end

      assert {404, [_h | _t], "{\"errors\":{\"detail\":\"Not Found\"}}"} = response
    end
  end

  describe "create link" do
    test "renders link when data is valid", %{conn: conn} do
      conn = post conn, link_path(conn, :create), link: %{url: "http://localhost:3000"}
      link = Repo.get_by!(Link, url: "http://localhost:3000")

      assert json_response(conn, 201) == %{
        "id" => link.hash,
        "url" => link.url
      }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, link_path(conn, :create), link: %{}

      assert json_response(conn, 422)["errors"] == %{
        "url" => ["can't be blank"]
      }
    end

    test "renders errors when link params are not present", %{conn: conn} do
      conn = post conn, link_path(conn, :create)

      assert json_response(conn, 422)["errors"] == %{
        "detail" => "Invalid params."
      }
    end
  end

  describe "update/2" do
    test "renders link when data is valid", %{conn: conn} do
      link = create(:link)
      conn = put conn, link_path(conn, :update, link), link: %{url: "http://localhost:4000"}

      assert json_response(conn, 200) == %{
        "id" => link.hash,
        "url" => "http://localhost:4000"
      }
    end

    test "renders errors when data is invalid", %{conn: conn} do
      link = create(:link)
      conn = put conn, link_path(conn, :update, link), link: %{url: ""}

      assert json_response(conn, 422)["errors"] == %{
        "url" => ["can't be blank"]
      }
    end
  end

  describe "delete link" do
    test "deletes chosen link", %{conn: conn} do
      link = create(:link)
      conn = delete conn, link_path(conn, :delete, link)

      assert response(conn, 204) == ""
    end

    test "renders error when link is not present", %{conn: conn} do
      response = assert_error_sent :not_found, fn ->
        get conn, link_path(conn, :delete, "test")
      end

      assert {404, [_h | _t], "{\"errors\":{\"detail\":\"Not Found\"}}"} = response
    end
  end
end
