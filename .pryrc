Pry.editor = 'nvim'
require 'amazing_print'

Pry.commands.alias_command('c', 'continue') if Pry::Commands['continue']
Pry.commands.alias_command('s', 'step') if Pry::Commands['step']
Pry.commands.alias_command('n', 'next') if Pry::Commands['next']
Pry.commands.alias_command 'e', 'exit'

BLACK = "\001\e[0;30m\002"
WHITE = "\001\e[0m\002"
Pry.prompt = [
  proc { |_target_self, _nest_level, pry|
    line_num = pry.input_array.size
    prompt = "#{line_num} "
    "#{BLACK}#{prompt}#{WHITE}"
  },
  proc { |_target_self, _nest_level, _pry|
    prompt = '. '
    "#{BLACK}#{prompt}#{WHITE}"
  }
]

Pry.config.ls.separator = "\n" # new lines between methods
Pry.config.ls.heading_color = :magenta
Pry.config.ls.public_method_color = :green
Pry.config.ls.protected_method_color = :yellow
Pry.config.ls.private_method_color = :bright_black

begin
  require 'amazing_print'
  Pry.config.print = proc { |output, value|
    value.ai
    value.ai.split("\n").each_with_index do |v, i|
      prefix = i == 0 ? '=>' : '. '
      output.puts "#{BLACK}#{prefix}#{WHITE} #{v}"
    end
  }
  AmazingPrint.defaults = {
    string_limit: 80,
    indent: 2,
    multiline: true,
    sort_keys: true
  }
  AwesomePrint.pry!
rescue LoadError
  puts 'gem install awesome_print  # <-- highly recommended'
end
Pry::Commands.command(/^clear$/, 'clear console') do
  system('clear')
end

Pry::Commands.command(/^clear!$/, 'clear console including tmux scrollback buffer') do
  system('clear!')
end
