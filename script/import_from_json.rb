#!/usr/bin/env ruby

require File.expand_path('../../config/environment',  __FILE__)

require 'json'
require 'wikicloth'
require 'pp'
require 'thread'

FEATURES_PER_TRANSACTION = 10
WORKER_THREADS = 1

$done = false
$work_queue = SizedQueue.new(20)
$record_count = 0

def create_or_update_by_triposo_id(data)
  f = Feature.find_by_triposo_id(data['id'])
  f = Feature.new if !f

  f.triposo_id = data['id']
  f.name = data['name']
  f.score = data['score']
  f.lat = data['lat'].to_f
  f.lng = data['lng'].to_f
  if data['wikipedia_raw']
    begin
      wikicloth = WikiCloth::Parser.new(:data => data['wikipedia_raw'])
      f.html = wikicloth.to_html
    rescue => e
      puts e
    end
  end

  f.save!
end

def process_n_lines
#  FEATURES_PER_TRANSACTION.times do
    begin
      return if $done
      line = $work_queue.deq
      $record_count += 1
      location = JSON.parse(line)

      create_or_update_by_triposo_id(location.merge!('type' => 'location'))

      location['pois'].each do |poi|
        create_or_update_by_triposo_id(poi.merge!('type' => 'poi'))
      end
#    rescue => e
#      puts e
#    end
  end
end

# Start worker threads.
WORKER_THREADS.times do
  Thread.new do
    while !$done
      Feature.transaction do
        process_n_lines
      end
    end
  end
end

# Start reporter thread.
Thread.new do
  while !$done
    sleep 10
    puts $record_count
  end
end

# Process input and pass to workers
$stdin.each_line do |line|
  $work_queue.enq(line)
end
$done = true
