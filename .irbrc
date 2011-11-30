def tramp_require(what, &block)
  loaded, require_result = false, nil

  begin
    require_result = require what
    loaded = true

  rescue Exception => ex
    puts "** Unable to require '#{what}'"
    puts "--> #{ex.class}: #{ex.message}"
  end

  yield if loaded and block_given?

  require_result
end

#require 'irb/completion'
tramp_require 'rubygems'
tramp_require 'looksee'
tramp_require 'wirble' do
  Wirble.init
  Wirble.colorize
end
tramp_require 'pp'


# Easily print methods local to an object's class
class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end

  # Return only the methods not present on basic objects
  def interesting_methods
    (self.methods - Object.new.methods).sort
  end
end

# Log to STDOUT if in Rails
if ENV.include?('RAILS_ENV') && !Object.const_defined?('RAILS_DEFAULT_LOGGER')
  require 'logger'
  RAILS_DEFAULT_LOGGER = Logger.new(STDOUT)
end

IRB.conf[:AUTO_INDENT]=true if defined? IRB

def gedit(content, filename='debug.txt', cleanup=true)
  File.open(filename, 'w') { |f| f.write(content) }
  `gedit #{filename}` # waits for Textmate to close file
  `rm -rf ./#{filename}` if cleanup
end

# Quick benchmarking
# Based on rue's irbrc => http://pastie.org/179534
def quick(repetitions=100, &block)
  require 'benchmark'

  Benchmark.bmbm do |b|
    b.report {repetitions.times &block} 
  end
  nil
end

HASH = { 
  :bob => 'Marley', :mom => 'Barley', 
  :gods => 'Harley', :chris => 'Farley'} unless defined?(HASH)
ARRAY = HASH.keys unless defined?(ARRAY)


IRB.conf[:PROMPT_MODE]  = :SIMPLE if defined? IRB

# Just for Rails...
if rails_env = ENV['RAILS_ENV'] and defined? IRB
  rails_root = File.basename(Dir.pwd)
  prompt = "#{rails_root}[#{rails_env.sub('production', 'prod').sub('development', 'dev')}]"
  IRB.conf[:PROMPT] ||= {}
  IRB.conf[:PROMPT][:RAILS] = {
    :PROMPT_I => "#{prompt}>> ",
    :PROMPT_S => "#{prompt}* ",
    :PROMPT_C => "#{prompt}? ",
    :RETURN => "=> %s\n"
  }
  IRB.conf[:PROMPT_MODE] = :RAILS
 
  # Called after the irb session is initialized and Rails has
  # been loaded (props: Mike Clark).
  IRB.conf[:IRB_RC] = Proc.new do
    #ActiveRecord::Base.logger = Logger.new(STDOUT)
    #ActiveRecord::Base.instance_eval { alias :[] :find }
  end
end 

# Default prompt
#IRB.conf[:PROMPT_MODE] = :DEFAULT
