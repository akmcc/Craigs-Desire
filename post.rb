require 'sinatra'
require 'sinatra/activerecord'

require_relative './environments'


class Post < ActiveRecord::Base

  def self::from_craigslist_html(html)
    post = Post.new

    title, extra  = title_from_html(html).split('-')
    post.title = title.strip
    if extra && category = extra.scan(/\w+4\w+/)[0]
      post.category = category
    end

    post.body = body_from_html(html)

    if listed_as_date?(html)
      post.posted_at = date_from_html(html)
    elsif listed_as_time?(html)
      post.posted_at = time_from_html(html)
    end

    post.craigslist_id = craigslist_id_from_html(html)
    post.city = city_from_html(html)
    post.state = post.city.downcase == 'portland' ? "OR" : "NY"

    return post
  end

  def self::title_from_html(html)
    html.at_css('.postingtitle').content.strip
  end

  def self::body_from_html(html)
    html.at_css('#postingbody').content.strip
  end

  def self::city_from_html(html)
    html.at_css('.area a').content.strip.downcase
  end

  def self::listed_as_date?(html)
    !html.at_css('.postinginfos date').nil?
  end

  def self::date_from_html(html)
    html.at_css('.postinginfos date').content.strip
  end

  def self::listed_as_time?(html)
    !html.at_css('.postinginfos time').nil?
  end

  def self::time_from_html(html)
    html.at_css('.postinginfos time').content.strip
  end

  def self::craigslist_id_from_html(html)
    html.at_css('.postinginfo:nth-child(1)').content.strip
  end
end