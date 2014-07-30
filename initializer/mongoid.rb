require "mongoid"
Mongoid.load!("config/mongoid.yml")
I18n.enforce_available_locales = false