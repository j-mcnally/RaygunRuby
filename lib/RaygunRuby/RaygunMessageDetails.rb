module RaygunRuby
  class RaygunMessageDetails
    attr_accessor :error, :machineName, :request, :client, :version, :tags, :userCustomData
    def initialize
      self.tags=[]
      self
    end
    def to_json
      {
        "Error" => self.error.to_json,
        "MachineName" => self.machineName,
        "Request" => self.request.to_json,
        "Client" => self.client.to_json,
        "Version" => self.version,
        "Tags" => self.tags.to_json,
        "UserCustomData" => self.userCustomData
      }
    end
  end
end