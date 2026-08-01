require 'rubygems'
require 'interactive_editor'
require 'irb/ext/save-history'
require 'irb/completion'

IRB.conf[:AUTO_INDENT] = true
IRB.conf[:SAVE_HISTORY] = 1000
IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"

def source_irbrc
  load '~/.irbrc'
end

module ShellWrapper

  require 'io/console'
  require 'colored'

  CONSOLE_THRESHOLD = 8

  def cd dir=ENV['HOME']

    Dir.chdir dir
    Dir.pwd
  end

  def ls dir=Dir.pwd
    entries = Dir["#{dir}/*"].map {|e| File.basename(e)}
    return 0 if entries.empty?
    max_width = entries.max_by(&:size).length + CONSOLE_THRESHOLD
    console_width = $stdout.winsize[1]
    output_split = console_width / max_width
    entries.each_slice(output_split) do |entry_slice|
      files = entry_slice.reduce('') do |memo, file|
        diff = max_width - file.length
        colored_entry = colored_entry(file)
        memo << colored_entry << (' ' * diff)
      end
      puts files
    end
    entries.size
  end

  def colored_entry entry
    return entry.cyan if File.directory?(entry)
    entry
  end

end

include ShellWrapper

