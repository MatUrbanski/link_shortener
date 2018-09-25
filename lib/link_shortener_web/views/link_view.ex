defmodule LinkShortenerWeb.LinkView do
  use LinkShortenerWeb, :view
  alias LinkShortenerWeb.LinkView

  def render("index.json", %{links: links}) do
    %{data: render_many(links, LinkView, "link.json")}
  end

  def render("show.json", %{link: link}) do
    render_one(link, LinkView, "link.json")
  end

  def render("link.json", %{link: link}) do
    %{id: link.hash,
      url: link.url}
  end
end
