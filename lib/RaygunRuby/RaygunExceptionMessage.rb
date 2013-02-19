module RaygunRuby
  class RaygunExceptionMessage
    attr_accessor :message, :classname, :stacktrace, :filename, :data
    def initialize(exception)
      exceptionClass = exception.class.name
      self.message = "#{exceptionClass}: #{exception.message}"
      begin
        backTraceLine = exception.backtrace.first
        self.filename = File::basename(backTraceLine.split(":").first)
        self.classname = File.basename(self.filename, ".rb").camelize
      rescue
        self.filename = "Unknown"
        self.classname = "Unknown"
      end
      self.stacktrace = exception.backtrace.collect{|bt| RaygunExceptionTraceLineMessage.new(bt) }
      self.data = nil
      self
    end
    def to_json
      {
        "Message" => self.message,
        "ClassName" => self.classname,
        "StackTrace" => self.stacktrace.collect{|s| s.to_json},
        "FileName" => self.filename,
        "Data" => self.data
      }
    end
  end
end