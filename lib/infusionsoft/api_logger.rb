module Infusionsoft
  class APILogger

    def info(msg); $stdout.print msg end

    def warn(msg); $stdout.print msg end

    def error(msg); $stdout.print msg end

    def debug(msg); $stdout.print msg end

    def fatal(msg); $stdout.print msg end
  end
end
