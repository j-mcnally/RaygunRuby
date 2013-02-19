namespace :raygun do
  desc "install raygun into project"
  task :install => [:environment] do
    ts = RaygunRuby::ThorStuff.new
    ts.invoke :create_raygun_config
  end
end