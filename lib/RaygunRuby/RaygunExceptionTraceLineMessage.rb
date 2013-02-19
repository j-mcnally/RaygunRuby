module RaygunRuby
  class RaygunExceptionTraceLineMessage
    attr_accessor :lineNumber, :className, :fileName, :methodName

    def initialize (logline)
      line = logline.split(":")
      self.lineNumber = line[1]
      self.fileName = line[0]
      self.methodName = line[2]
      self.className = File.basename(self.fileName, ".rb")
    end

    def api_attributes
      {
        "LineNumber" => self.lineNumber.to_i,
        "ClassName" => self.className,
        "FileName" => self.fileName,
        "MethodName" => self.methodName
      }
    end

  end
end