module Infusionsoft
  class APILogger

    def info; end
    def info(msg); $stdout.print msg end

    def warn; end
    def warn(msg); $stdout.print msg end

    def error; end
    def error(msg); $stdout.print msg end

    def debug; end
    def debug(msg); $stdout.print msg end

    def fatal; end
    def fatal(msg); $stdout.print msg end
  end
end
