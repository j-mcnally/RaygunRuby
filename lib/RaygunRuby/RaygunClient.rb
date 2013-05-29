require "faraday"

module RaygunRuby
  class RaygunClient


    def self.send_exception(exception, tags=nil, userCustomData=nil, env=nil)
      msg = self.build_message(exception, env)
      self.send_msg(msg)

    end

    def self.build_message(errorException, env)

      message = RaygunMessage.new()
      message.build(errorException, env)

    end

    def self.send_msg(message)
      begin
        apiKey = RaygunRuby::Config::read["apiKey"]
      rescue 
        raise "API_KEY not valid, cannot send message to Raygun"
      end
      bdy = message.api_attributes.to_json
	    spec = Gem::Specification.find_by_name("RaygunRuby")
        path = spec.gem_dir + "/vendor/cacert.crt"
        connection = Faraday.new 'https://api.raygun.io', :ssl => {:ca_file => path} do |faraday|
            faraday.response :logger                  # log requests to STDOUT
            faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
        end

        request = connection.post do |req|
          req.url "/entries"
          req.headers["X-ApiKey"] = apiKey
          req.headers['Content-Type'] = 'application/x-www-form-urlencoded'
          req.headers['User-Agent'] = "Hai Raygun"
          req.body = bdy

        end

        puts request.body

              

    end


  end
end