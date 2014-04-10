xml.instruct!
xml.urlset xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9" do
  xml.url do
    xml.loc root_url
    xml.lastmod NewsRelease.order(updated_at: :desc).first.updated_at.strftime "%Y-%m-%d"
  end

  Product.available.each do |product|
    xml.url do
      xml.loc product_url(product)
      xml.lastmod product.updated_at.strftime "%Y-%m-%d"
    end
  end

  Series.all.each do |series|
    xml.url do
      xml.loc catalog_url(action: :series, id: series.identify)
      xml.lastmod series.products.order(updated_at: :desc).last.updated_at.strftime "%Y-%m-%d"
    end
  end
end
