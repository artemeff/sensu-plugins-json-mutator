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
require 'sensu-plugin'
require 'sensu-plugins-json-mutator/mutator'

class JSONMutator < Sensu::Mutator
  GRAPHITE = /([\w\.]+)\s(.+).*/  # sample.key 42.13 1462521982
  STATSD   = /([\w\.]+):(.*)\|.*/ # sample.key:42.13|kv

  def mutate
    lines = @event['check']['output'].lines

    @event['check']['output'] = parse_lines(lines, GRAPHITE) if lines.first =~ GRAPHITE
    @event['check']['output'] = parse_lines(lines, STATSD) if lines.first =~ STATSD
  end

private

  def parse_lines(lines, regexp)
    kv = {}

    lines.each do |line|
      result = line.match(regexp)
      kv[result[1]] = result[2].to_f if result
    end

    kv
  end
end
