require_relative 'missed_connections'
require_relative 'helpers'
require_relative 'language_processing'
require_relative 'data'
require 'sinatra/activerecord'
require 'sinatra'
require './environments'




class Post < ActiveRecord::Base
end

class Stats < ActiveRecord::Base
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
  @language = LangProcessor.new
  @pdx_analyzer = DataAnalyzer.new(Post.where(city: "Portland"))
  @nyc_analyzer = DataAnalyzer.new(Post.where(city: "New York City"))
  @pdx_count = @pdx_analyzer.post_count
  @nyc_count = @nyc_analyzer.post_count
  @pdx_prob = @language.pdx_prob
  @nyc_prob = @language.nyc_prob
  @pdx_nouns = @language.most_common_nouns(@language.pdx_nouns)
  @nyc_nouns = @language.most_common_nouns(@language.nyc_nouns)
  @generic_pdx = @language.generic_post(@pdx_prob)
  @generic_nyc = @language.generic_post(@nyc_prob)
  haml :stats
end

get '/add_more_data' do
  # data = Connection.new
  # data.save_recent_missed_connections
  LangProcessor.new.update_stats
  "Hello"

end