require 'benchmark'
require 'psych'
require 'psych/y'

begin
  require 'awesome_print'
  AwesomePrint.pry!
rescue LoadError
end

default_command_set =
  Pry::CommandSet.new do
    command 'clear' do
      system 'clear'
    end

    command 'q' do
      exit!
    end

    command 'caller_methods' do |depth|
      if depth.nil?
        output.puts caller.join("\n")
      else
        depth = depth.to_i || 1
        if /^(.+?):(\d+)(?::in `(.*)')?/ =~ caller(depth+1).first
          file   = Regexp.last_match[1]
          line   = Regexp.last_match[2].to_i
          method = Regexp.last_match[3]
          output.puts ["file: #{file}","line: #{line}","method: #{method}"]
        end
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
Pry.config.commands.alias_command 'b', 'exit'
Pry.config.commands.alias_command 'lg', 'ls --grep'
Pry.config.commands.alias_command 'wa', 'whereami'

## pry-byebug
if defined?(PryByebug)
  Pry.commands.alias_command 'c', 'continue'
  Pry.commands.alias_command 's', 'step'
  Pry.commands.alias_command 'n', 'next'
  Pry.commands.alias_command 'f', 'finish'
end

def rp(obj)
  Pry::ColorPrinter.pp obj
end

## awesome_print
if defined?(AwesomePrint)
  def a(obj)
    ap obj
  end
end

## rails
rails_environment_file_path = File.join(Dir.getwd,'config','environment.rb')

if File.exist?(rails_environment_file_path)
  require 'rails'

  # r! to reload Rails console
  def r!; reload! end

  # SQL commands through the AR
  def sql(query)
    ActiveRecord::Base.connection.execute(query)
  end

  # show model associations
  def show_associations(instance)
    if !instance.is_a? ActiveRecord::Base
      p 'Not an instance of ActiveRecord::Base'
      return
    end

    associations = instance.class.reflect_on_all_associations.map do |association|
      ":#{association.macro} => :#{association.name}"
    end

    puts associations.joins("\n")
  end
end
