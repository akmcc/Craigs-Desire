class Connection

  def initialize
    @site = "http://portland.craigslist.org"
  end
  
  def save_recent_missed_connections
    doc = generate_doc 
    links = doc.css('.pl a')
    links.each do |link|
      save_post_data(link)
    end
  end

  def generate_doc
    Nokogiri::HTML(open("#{@site}/mis/"))
  end

  def generate_sub_doc(link)
    Nokogiri::HTML(open("#{@site}#{link['href']}"))
  end

  def collect_links_to_posts(doc)
    return doc.css('.pl a')
  end

  def save_post_data(link)
    post = Post.new
    sub_doc = generate_sub_doc(link)
    post.title = title(sub_doc)
    post.body = body(sub_doc)
    if listed_as_date?(sub_doc)
      post.date_posted = date(sub_doc)
    elsif listed_as_time?(sub_doc) 
      post.date_posted = time(sub_doc)
    end
    post.post_id = post_id(sub_doc)
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
