require_relative 'missed_connections'
require_relative 'helpers'
require_relative 'language_processing'
require_relative 'data'

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
  all_posts = []
  Post.all.each do |post|
    all_posts << post
  end
  @data = PostData.new(all_posts)
  @post_count = @data.data_source.size
  @first_post_date = @data.first_and_last[0]
  @last_post_date = @data.first_and_last[-1]

  # @all_posts = []
  # body_text = ""
  # Post.all.each do |post|
  #   @all_posts << post
  #   body_text << post.body
  # end
  @generic_post = LangProc.new.generic_post
  @common_adjectives = LangProc.new.adjective_popularity
  haml :stats
end

get '/add_more_data' do
  data = Connection.new
  data.save_recent_missed_connections
end