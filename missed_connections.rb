class Connection
  #dear god this needs refactoring
  def save_recent_missed_connections
    city = "portland"
    site = "http://#{city}.craigslist.org"
    doc = Nokogiri::HTML(open("http://portland.craigslist.org/mis/index400.html"))
    links = doc.css('.pl a') #=> returns objects like <a href="/clk/mis/4157627907.html">Ian???I think...</a>
    links[0..100].each do |link| 
      @post = Post.new 
      sub_doc = Nokogiri::HTML(open("#{site}#{link['href']}"))
      @post.title = title(sub_doc)#((sub_doc.at_css('.postingtitle')).content).strip
      @post.body = body(sub_doc) #((sub_doc.at_css('#postingbody')).content).strip
      if listed_as_date?(sub_doc) #!(sub_doc.at_css('.postinginfos date')).nil?
        @post.date_posted = date(sub_doc) #((sub_doc.at_css('.postinginfos date')).content).strip
      elsif listed_as_time?(sub_doc) #!(sub_doc.at_css('.postinginfos time')).nil?
        @post.date_posted = time(sub_doc) #((sub_doc.at_css('.postinginfos time')).content).strip
      end
      @post.post_id = post_id(sub_doc) #((sub_doc.at_css('.postinginfo:nth-child(1)')).content).strip
      @post.save
    end
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
