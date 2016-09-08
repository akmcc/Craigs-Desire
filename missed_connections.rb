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
    post = Post.new
    sub_doc = generate_sub_doc(site, link)
    post.title = title(sub_doc)
    post.body = body(sub_doc)
    if listed_as_date?(sub_doc)
      post.date_posted = date(sub_doc)
    elsif listed_as_time?(sub_doc) 
      post.date_posted = time(sub_doc)
    end
    post.post_id = post_id(sub_doc)
    city = site.include?("portland") ? "Portland" : "New York City"
    post.city = city
    post.save
  end

  def title(sub_doc)
    sub_doc.at_css('.postingtitle').content.strip
  end

  def body(sub_doc)
    sub_doc.at_css('#postingbody').content.strip
  end

  def listed_as_date?(sub_doc)
    !sub_doc.at_css('.postinginfos date').nil?
  end

  def date(sub_doc)
    sub_doc.at_css('.postinginfos date').content.strip
  end

  def listed_as_time?(sub_doc)
    !sub_doc.at_css('.postinginfos time').nil?
  end

  def time(sub_doc)
    sub_doc.at_css('.postinginfos time').content.strip
  end

  def post_id(sub_doc)
    sub_doc.at_css('.postinginfo:nth-child(1)').content.strip
  end
end
