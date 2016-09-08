require 'sinatra'
require 'sinatra/activerecord'
require 'google_visualr'
require 'nokogiri'
require 'open-uri'
require 'haml'
require 'googlecharts'

require_relative './environments'
require_relative 'missed_connections'
require_relative 'post'
require_relative 'helpers'
require_relative 'language_processing'
require_relative 'data'

class Stats < ActiveRecord::Base
end

class Craigslust < Sinatra::Base
  get '/' do
    @display_results = false
    @button_text = rand(2)
    haml :index
  end

  post '/' do
    @display_results = true
    @results = []
    @search_term = params[:search]
    # fix this vulnerability to sql injection
    Post.where("body like '%#{@search_term}%'").each do |post|
      @results << post
    end
    haml :index
  end

  get '/stats' do
    @language = LangProcessor.new

    # can get rid of these as soon as I create a real dataset for
    # filtering by the time of day they were posted
    @pdx_analyzer = DataAnalyzer.new(Post.portland)
    @nyc_analyzer = DataAnalyzer.new(Post.new_york)

    @pdx_count = Post.portland.count
    @nyc_count = Post.new_york.count
    @pdx_prob = @language.pdx_prob
    @nyc_prob = @language.nyc_prob
    @pdx_nouns = @language.most_common_nouns(@language.pdx_nouns)
    @nyc_nouns = @language.most_common_nouns(@language.nyc_nouns)
    @generic_pdx = @language.generic_post(@pdx_prob)
    @generic_nyc = @language.generic_post(@nyc_prob)
    haml :stats
  end

  get '/add_more_data' do
    data = Connection.new
    data.save_recent_missed_connections
    LangProcessor.new.update_stats
    "Done"
  end
end
