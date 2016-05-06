#! /usr/bin/env ruby
# encoding: UTF-8
#
# mutator-json
#
# DESCRIPTION:
#   Accepts Graphite or Statsd output and transforms it to json format
#
# OUTPUT:
#   json
#
# PLATFORMS:
#   Linux
#
# DEPENDENCIES:
#   gem: sensu-plugin

require 'json'

GRAPHITE = /([\w\.]+)\s(.+).*/  # sample.key 42.13 1462521982
STATSD   = /([\w\.]+):(.*)\|.*/ # sample.key:42.13|kv

def parse_lines(lines, regexp)
  kv = {}

  lines.each do |line|
    result = line.match(regexp)
    kv[result[1]] = result[2].to_f if result
  end

  kv
end

event = JSON.parse(STDIN.read)
lines = event['check']['output'].lines

event['check']['output'] = parse_lines(lines, GRAPHITE) if lines.first =~ GRAPHITE
event['check']['output'] = parse_lines(lines, STATSD) if lines.first =~ STATSD

puts JSON.dump(event)
