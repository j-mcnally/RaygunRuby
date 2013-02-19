module RaygunRuby
  class RaygunMessageDetails
    attr_accessor :error, :machineName, :request, :client, :version, :tags, :userCustomData
    def initialize
      self.tags=[]
      self
    end
    def api_attributes
      {
        "Error" => self.error.api_attributes,
        "MachineName" => self.machineName,
        "Request" => self.request.api_attributes,
        "Client" => self.client.api_attributes,
        "Version" => self.version,
        "Tags" => self.tags.to_json,
        "UserCustomData" => self.userCustomData
      }
    end
  end
end