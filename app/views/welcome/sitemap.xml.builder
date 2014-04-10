xml.instruct!
xml.urlset xmlns: "http://www.sitemaps.org/schemes/sitemap/0.9" do
  xml.url do
    xml.loc root_url
    xml.lastmod ""
  end

  Product.available.each do |product|
    xml.url do
      xml.loc product_url(product)
      xml.lastmod product.updated_at
    end
  end
end
