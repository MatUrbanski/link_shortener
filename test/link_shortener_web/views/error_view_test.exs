defmodule LinkShortenerWeb.ErrorViewTest do
  use LinkShortenerWeb.ConnCase, async: true

  alias LinkShortenerWeb.ErrorView

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.json" do
    assert render(ErrorView, "404.json", []) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500.json" do
    assert render(ErrorView, "500.json", []) == %{errors: %{detail: "Internal Server Error"}}
  end

  test "renders 422.json" do
    assert render(ErrorView, "422.json", []) == %{errors: %{detail: "Invalid params."}}
  end
end
