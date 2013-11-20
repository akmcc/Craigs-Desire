require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'nokogiri'
require 'open-uri'
require 'Haml'
require_relative 'word_count'
require_relative 'missed_connections'

class Post < ActiveRecord::Base
end



get '/' do
  @display_results = false
  haml :index
end

post '/' do
  @display_results = true
  @results = []
  @search_term = params[:search]
  Post.where("body like '% #{@search_term} %'").each do |post|
    @results << post
  end
  haml :index
end

get '/stats' do
  @all_posts = []
  body_text = ""
  Post.all.each do |post|
    @all_posts << post
    body_text << post.body
  end
  @word_counts = WordCount.new(body_text).word_count.sort_by{|word, quantity| quantity}
  @m4m = Post.where("title like '% m4m %'").count
  @m4w = Post.where("title like '% m4w %'").count
  @w4w = Post.where("title like '% w4w %'").count
  @w4m = Post.where("title like '% w4m %'").count
  haml :stats
end

get '/add_more_data' do
  data = Connection.new
  data.save_recent_missed_connections
end