require 'sinatra'
require 'sinatra/activerecord'
require './environments'
require 'nokogiri'
require 'open-uri'
require 'Haml'
require 'googlecharts'


require './app'
run Sinatra::Application