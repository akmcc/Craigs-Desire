require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'nokogiri'
require 'open-uri'
require_relative 'word_count'
require_relative 'missed_connections'

class Post < ActiveRecord::Base
end

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
      @post.title = ((sub_doc.at_css('.postingtitle')).content).strip
      @post.body = ((sub_doc.at_css('#postingbody')).content).strip
      if !(sub_doc.at_css('.postinginfos date')).nil?
        @post.date_posted = ((sub_doc.at_css('.postinginfos date')).content).strip
      elsif !(sub_doc.at_css('.postinginfos time')).nil?
        @post.date_posted = ((sub_doc.at_css('.postinginfos time')).content).strip
      end
      @post.post_id = ((sub_doc.at_css('.postinginfo:nth-child(1)')).content).strip
      @post.save
    end
  end
end

get '/' do
  @display_results = false
  erb :index
end

post '/' do
  @display_results = true
  @results = []
  @search_term = params[:search]
  Post.where("body like '% #{@search_term} %'").each do |post|
    @results << post
  end
  erb :index
end

get '/stats' do
  @all_posts = []
  body_text = ""
  Post.all.each do |post|
    @all_posts << post
    body_text << post.body
  end
  @word_counts = WordCount.new(body_text).word_count.sort_by{|word, quantity| quantity}

  erb :stats
end

get '/add_more_data' do
  data = Connection.new
  data.save_recent_missed_connections
end