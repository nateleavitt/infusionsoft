module Infusionsoft
  class APILogger

    def info; end
    def info(msg); puts msg end

    def warn; end
    def warn(msg); puts msg end

    def error; end
    def error(msg); puts msg end

    def debug; end
    def debug(msg); puts msg end

    def fatal; end
    def fatal(msg); puts msg end
  end
end
