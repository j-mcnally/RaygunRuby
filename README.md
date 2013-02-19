# RaygunRuby

Integrate rails with the Raygun.io service.

I, nor kohactive are in anyway associated with the offical raygun.io, we just couldn't wait for them to develop a rails solution so we rolled our own.

Throwing exceptions has never been so much fun.





## Installation

Add this line to your application's Gemfile:

    gem 'RaygunRuby', '0.9.6'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install RaygunRuby

Also generate a raygun.yml with
    
    $ rake raygun:install

## Usage

Add the following to which ever config/environment files you want to use with raygun
    
    config.middleware.use RaygunRuby::Middleware

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
