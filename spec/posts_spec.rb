require './post'
require 'nokogiri'
# require_relative 'post_html.html'

RSpec.describe Post do

  let( :html_doc ) { File.open("spec/post_html.html") { |f| Nokogiri::XML(f) } }

  describe "::from_craigslist_html" do
    it "it creates a new post" do
      puts "should be here"
      print html_doc.at_css('.postingtitletext').content
      result = Post.from_craigslist_html(html_doc)
      expect{ Post.from_craigslist_html(html_doc).save }.to change{ Post.count }.by( 1 )
    end
  end
end
