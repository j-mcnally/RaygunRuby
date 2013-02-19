require "awesome_print"

module RaygunRuby
  class RaygunRequestMessage
    attr_accessor :hostName, :url, :httpMethod, :ipAddress, :queryString, :headers, :data, :form, :rawData
    def initialize(env)
      return nil if env.nil?
      self.hostName = env["HTTP_HOST"]
      self.url = env["PATH_INFO"]
      self.httpMethod = env["REQUEST_METHOD"]
      self.ipAddress = env["REMOTE_ADDR"]
      self.queryString = env["QUERY_STRING"].present? ? env["QUERY_STRING"] : nil
      header_hash = env.keys.reject{|x| !x.include?("HTTP")}.map{|k| {"#{k}" => env[k]} }.map(&:to_a).flatten(1).reduce({}) {|h,(k,v)| h[k] = v; h}
      hash_out = header_hash.dup
      header_hash.each { |k, v| hash_out[k.to_s.sub("HTTP_", "").sub("_", " ").titleize.sub(" ", "-")] = v; hash_out.delete(k) }
      header_hash = hash_out
      self.headers = header_hash
      self.data = env.inspect.to_s
      self.form = env["action_dispatch.request.parameters"] rescue {}
      self.rawData = nil
    end

    def api_attributes
      {
        hostName: self.hostName,
        url: self.url,
        httpMethod: self.httpMethod,
        ipAddress: self.ipAddress,
        queryString: self.queryString,
        headers: self.headers,
        data: self.data,
        form: self.form,
        rawData: self.rawData
      }
    end

  end
end