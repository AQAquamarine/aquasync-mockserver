Gem::Specification.new do |gem|
  gem.name    = 'aquasync_model'
  gem.version = '0.2.1'
  gem.date    = Date.today.to_s

  gem.summary = "A mixin model which implements Aquasync Model specification."
  gem.description = "A mixin to help development of Aquasync."
  gem.licenses = "MIT"

  gem.authors  = ['kaiinui']
  gem.email    = 'me@kaiinui.com'
  gem.homepage = 'https://github.com/AQAquamarine/aquasync_model'

  gem.add_dependency 'mongoid', ["~> 4.0"]
  gem.add_dependency 'activesupport', ["~> 4.0"]
  gem.add_dependency 'simple_uuid', ["~> 0.4"]
  gem.add_dependency 'activerecord', ["~> 4.0"]
  gem.add_development_dependency 'rspec', ["~> 3.0"]
  gem.add_development_dependency 'guard-rspec', ["~>4.3"]
  gem.add_development_dependency 'factory_girl', ["~> 4.4"]
  gem.add_development_dependency 'database_cleaner', ["~> 1.3"]

  gem.files = ["lib/models/base.rb", "lib/models/concerns/aquasync_aggregated_methods.rb", "lib/models/concerns/aquasync_callbacks.rb", "lib/models/concerns/aquasync_delta_pack_methods.rb", "lib/validators/aquasync_validator.rb", "lib/aquasync_model.rb"]
end