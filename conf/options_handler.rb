require_relative 'usage'
require 'optparse'
require 'launchy'
require 'byebug'

module RBPG
  ORIGINAL_ARGV = ARGV.dup

  Options = Struct.new(:topic, :example)

  class Parser
    def self.parse
      args = Options.new(0, 0)
      
      options_parser = OptionParser.new do |opts|
        opts.default_argv = %w[--no-op] if ARGV.empty?

        opts.on("-t", "--topic=TOPIC", "Specify a specific topic. Can be expressed as a range (e.g. 1-5).") do |t|
          args.topic = t
        end

        opts.on("-e", "--example=EXAMPLE", "Specify a specific example. Assumes that an exact topic has been specified.") do |e|
          args.example = e
        end

        opts.on("-l", "--list", "Display a list of topics and examples.") do |opt|
          puts "Not yet implemented."
          # TODO: Write a function to list topics/examples...
        end

        opts.on("-q", "--quiet", "Run in quiet mode (do not display navigation menus).") do |opt|
          options[:quiet] = opt
        end

        opts.on("-c", "--create", "Enter create-mode.") do |opt|
          puts "Not yet implemented."
          # TODO: write a function for the create process...
        end

        opts.on("-h", "--help", "Display this menu.") do
          puts RBPGDocs.man_page(opts)
          exit
        end

        opts.on("--no-op") do
          puts RBPGDocs.man_page(opts)
          exit
        end
      end

      options_parser.parse!
      return args
    end
  end

  def self.get_script_options
    Parser.parse
  end

  def self.open_in_browser(uri)
    Launchy.open(uri.to_s)
  end
end

RBPG.get_script_options # Returns the arguments 
