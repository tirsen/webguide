#!/usr/bin/env ruby

require File.expand_path('../../config/environment',  __FILE__)

require 'json'
require 'wikicloth'
require 'pp'

TOP_ZOOM_LEVEL_FEATURE_COUNT = 128

Feature.connection.update("UPDATE features SET first_zoom_level = 4")
2.downto(0) do |i|
  feature_count = TOP_ZOOM_LEVEL_FEATURE_COUNT * (2 ** i)
  Feature.find(:all, :order => 'score DESC', :limit => feature_count).each do |f|
    f.first_zoom_level = i + 1
    f.save!
  end
end
