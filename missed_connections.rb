class Connection

  def initialize
    @sites = ["http://portland.craigslist.org", "http://newyork.craigslist.org"]
  end

  def save_recent_missed_connections
    @sites.each do |site|
      doc = generate_doc(site)
      links = doc.css('.pl a')
      links.each do |link|
        save_post_data(site, link)
      end
    end
  end

  private

  def generate_doc(site)
    Nokogiri::HTML(open("#{site}/mis/index300.html"))
  end

  def generate_sub_doc(site, link)
    Nokogiri::HTML(open("#{site}#{link['href']}"))
  end

  def save_post_data(site, link)
    sub_doc = generate_sub_doc(site, link)
    post = Post.from_craigslist_html(sub_doc)
    post.save
  end
end