 defmodule AmazonSpider do
  use Crawly.Spider

  require URI

  alias Costmap.Products


  @impl Crawly.Spider
  def base_url(), do: "https://www.amazon.com/"


  @impl Crawly.Spider
  def init(opts) do
    name = Keyword.get(opts, :name)
    search_url = URI.encode("https://www.amazon.com/s?k=" <> name)
    amazon_search_url = URI.parse(search_url) |> to_string()
    [start_urls: [amazon_search_url]]
    # URI.parse("https://www.amazon.com/s?k=infinix&ref=nb_sb_noss")
  end


  @impl Crawly.Spider
  def parse_item(response) do
    # Parse response body to document
    {:ok, document} = Floki.parse_document(response.body)

    # IO.inspect(document)

    items =
      document
      |> Floki.find("div.s-result-item[data-component-type=s-search-result]")
      |> Enum.map(fn x ->
        %{
          name: Floki.find(x, "h2 > a > span") |> Floki.text(),
          price_symbol: Floki.find(x, "span span.a-price-symbol") |> Floki.text(),
          price_whole: Floki.find(x, "span span.a-price-whole") |> Floki.text(),
          price_fraction: Floki.find(x, "span span.a-price-fraction") |> Floki.text(),
          asin: Floki.attribute(x, "data-asin") |> Floki.text(),
          image_url: Floki.find(x, "div img.s-image") |> Floki.attribute("src") |> Floki.text(),
        }
      end)

    %{items: items}
  end

end
