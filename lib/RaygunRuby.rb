require "RaygunRuby/version"
require "RaygunRuby/RaygunClientMessage"
require "RaygunRuby/RaygunMessageDetails"
require "RaygunRuby/RaygunRequestMessage"
require "RaygunRuby/RaygunExceptionMessage"
require "RaygunRuby/RaygunExceptionTraceLineMessage"
require "RaygunRuby/RaygunMessage"
require "RaygunRuby/RaygunClient"
require "RaygunRuby/base"



module RaygunRuby
  class Middleware
    include RaygunRuby::Base
  end
  class Config
    def self.read
      YAML.load_file("#{Rails.root}/config/raygun.yml")["#{ENV['RAILS_ENV']}"]
    end
  end
end

require "RaygunRuby/thor_stuff"
require "RaygunRuby/railties"
