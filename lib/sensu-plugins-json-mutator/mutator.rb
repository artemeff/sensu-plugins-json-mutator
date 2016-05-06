require 'json'
require 'sensu-plugin/utils'
require 'mixlib/cli'

module Sensu
  class Mutator
    include Sensu::Plugin::Utils
    include Mixlib::CLI

    attr_accessor :argv

    def initialize(argv = ARGV)
      super()
      self.argv = parse_options(argv)
    end

    def mutate
      ## Override this, be sure any changes are made to @event
      nil
    end

    def dump
      puts JSON.dump(@event)
    end

    # This works just like Plugin::CLI's autorun.
    @@autorun = self
    class << self
      def method_added(name)
        if name == :mutate
          @@autorun = self
        end
      end
    end

    def self.disable_autorun
      @@autorun = false
    end

    at_exit do
      if @@autorun
        mutator = @@autorun.new
        mutator.read_event(STDIN)
        mutator.mutate
        mutator.dump
      end
    end
  end
end
