require_relative 'word_count'
require_relative 'missed_connections'
require_relative 'helpers'
require_relative 'language_processing'

class Post < ActiveRecord::Base
end

get '/' do
  @display_results = false
  @button_text = rand(2)
  haml :index
end

post '/' do
  @display_results = true
  @results = []
  @search_term = params[:search]
  Post.where("body like '%#{@search_term}%'").each do |post|
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
  @word_counts = WordCount.new(body_text).word_count
  @generic_post = LangProc.new.generic_post
  @common_adjectives = LangProc.new.adjective_popularity
  haml :stats
end

get '/add_more_data' do
  data = Connection.new
  data.save_recent_missed_connections
end