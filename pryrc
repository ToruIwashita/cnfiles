require 'benchmark'

default_command_set = Pry::CommandSet.new do
  command 'clear' do
    system 'clear'
  end

  command 'q!' do
    exit!
  end

  command 'caller_method' do |depth|
    depth = depth.to_i || 1
    if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(depth+1).first
      file   = Regexp.last_match[1]
      line   = Regexp.last_match[2].to_i
      method = Regexp.last_match[3]
      output.puts ["file: #{file}","line: #{line}","method: #{method}"]
    end
  end

  command 'benchmark' do |repeat=1000,&blk|
    Benchmark.bmbm do |x|
      x.report { repeat.times(&blk) }
    end
    nil
  end
end

Pry.config.commands.import default_command_set
Pry.config.commands.alias_command 'q', 'exit'
Pry.config.commands.alias_command 'lg', 'ls --grep'

## Rails
rails = File.join(Dir.getwd,'config','environment.rb')

if File.exist?(rails)
  require 'rails'

  # r! to reload Rails console
  def r!; reload! end

  # SQL commands through the AR
  def sql(query)
    ActiveRecord::Base.connection.execute(query)
  end
end
