module RaygunRuby
  class RaygunClientMessage
    attr_accessor :name, :version, :clientUrl

    def initialize
      self.name = "RaygunRuby"
      self.version = RaygunRuby::VERSION
      self.clientUrl = "https://github.com/j-mcnally/RaygunRuby"
      self
    end

    def to_json
      {
        name: self.name,
        version: self.version,
        clientUrl: self.clientUrl
      }
    end
  end
end