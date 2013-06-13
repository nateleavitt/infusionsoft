module Infusionsoft
  class APILogger

    def info; end
    def info(msg); $stdout.print msg end

    def warn; end
    def warn(msg); $stdout.print msg end

    def error; end
    def error(msg); $stdout.print msg end

    # def debug; end
    # def fatal; end
  end
end
