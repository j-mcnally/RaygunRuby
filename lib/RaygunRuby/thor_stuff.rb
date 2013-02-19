require 'rubygems'
require 'thor'
module RaygunRuby
  class ThorStuff < Thor
    include Thor::Actions

    def self.source_root
      File.dirname(__FILE__)
    end
    

    desc "create_raygun_config", "Create a raygun config"
    def create_raygun_config
      @apiKey = ask "What is your RayGun api key?:"
      template "../../templates/raygun_yaml.tt", "#{Rails.root}/config/raygun.yml"
      puts "Generating raygun.yml"
      puts "You can edit the configuration in config/raygun.yml"
    end

  end
end