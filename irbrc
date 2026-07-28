require 'benchmark'
require 'psych'
require 'psych/y'
require 'irb/color_printer'

module LocalIrbCommands
  class Clear < IRB::Command::Base
    category 'Local'
    description 'Clear the screen'

    def execute(_arg)
      system 'clear'
    end
  end

  class Quit < IRB::Command::Base
    category 'Local'
    description 'Exit the process immediately'

    def execute(_arg)
      exit!
    end
  end

  class CallerMethods < IRB::Command::Base
    category 'Local'
    description 'Show the caller stack outside of IRB'

    help_message <<~HELP_MESSAGE
      Usage: caller_methods [depth]

        depth  Show file/line/method of the frame at the given depth (1 origin).
    HELP_MESSAGE

    # IRBのコマンドはIRB自身のフレーム上で実行されるためcallerにIRB内部が積まれる
    # binding.irbのフレームを境界として,それより外側(アプリ側)のみを対象にする
    def execute(arg)
      frames = caller
      boundary = frames.rindex { |frame| frame.include?("in 'Binding#irb'") }
      frames = frames[(boundary + 1)..] if boundary

      if arg.strip.empty?
        puts frames.join("\n")
      else
        frame = frames[arg.to_i - 1]
        # Ruby 3.4でバックトレースの引用符が`method'から'method'へ変わったため両方を許容する
        if frame && /^(.+?):(\d+)(?::in [`'](.*)')?/ =~ frame
          file   = Regexp.last_match[1]
          line   = Regexp.last_match[2].to_i
          method = Regexp.last_match[3]
          puts ["file: #{file}", "line: #{line}", "method: #{method}"]
        end
      end
    end
  end

  class LsGrep < IRB::Command::Base
    category 'Local'
    description 'Alias for `ls -g`'

    def execute(arg)
      IRB::Command::Ls.execute(irb_context, "-g #{arg}")
    end
  end
end

IRB::Command.register(:clear, LocalIrbCommands::Clear)
IRB::Command.register(:q, LocalIrbCommands::Quit)
IRB::Command.register(:caller_methods, LocalIrbCommands::CallerMethods)
IRB::Command.register(:lg, LocalIrbCommands::LsGrep)

IRB.conf[:COMMAND_ALIASES] = IRB.conf[:COMMAND_ALIASES].merge(
  b: :exit,
  wa: :whereami,
  c: :continue,
  s: :step,
  n: :next,
  f: :finish
)

def benchmark(repeat = 1000, &blk)
  Benchmark.bmbm do |x|
    x.report { repeat.times(&blk) }
  end
  nil
end

def rp(obj)
  IRB::ColorPrinter.pp obj
end

## rails
rails_environment_file_path = File.join(Dir.getwd, 'config', 'environment.rb')

if File.exist?(rails_environment_file_path)
  require 'rails'

  # r! to reload Rails console
  def r!; reload! end

  # SQL commands through the AR
  def sql(query)
    ActiveRecord::Base.connection.execute(query)
  end

  # show model associations
  def show_associations(instance_or_klass)
    klass =
      if instance_or_klass.respond_to?(:reflect_on_all_associations)
        instance_or_klass
      else
        instance_or_klass.class
      end

    associations = klass.reflect_on_all_associations.map do |association|
      ":#{association.macro} => :#{association.name}"
    end

    puts associations.join("\n")
  end
end
