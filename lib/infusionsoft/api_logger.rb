module Infusionsoft
  class APILogger

    def info(msg); $stdout.puts msg end

    def warn(msg); $stdout.puts msg end

    def error(msg); $stdout.puts msg end

    def debug(msg); $stdout.puts msg end

    def fatal(msg); $stdout.puts msg end
  end
end
