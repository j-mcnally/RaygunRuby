require "awesome_print"

module RaygunRuby
  module Base
    def self.included(base)
      base.class_eval do
        include Includes
      end
    end
  end
  module Includes

    def initialize(app)
      @ready = false
      begin
        key = RaygunRuby::Config::read["apiKey"]
        puts "RayGun is charged"
        @ready = true
      rescue
        puts "RayGun API Key is not configured::: run 'rake raygun:install'"
      end



      @app = app

    end 

    def call(env)
      dup._call(env) if @ready
    end
    
    def _call(env)
      _env = env.dup
      begin
        @app.call(_env)
      rescue Exception => exception
        raygun_handle_and_rethrow(exception,_env)
      end
    end
    def raygun_handle_and_rethrow(exception, _env)
      backtrace = exception.backtrace.join("\n")
      message = exception.message
      #ap env

      RaygunRuby::RaygunClient::send_exception(exception, nil, nil, _env)

      raise exception
    end

  end
end