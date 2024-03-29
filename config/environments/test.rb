Userprog::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Log error messages when you accidentally call methods on nil
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr

  #One thing you will quickly notice when running tests with Factory Girl is that they are slow. The reason is not Factory Girl’s fault, and in fact it is a feature, not a bug. The issue is that the BCrypt algorithm used in Section 6.3.1 to create a secure password hash is slow by design: BCrypt’s slow speed is part of what makes it so hard to attack. Unfortunately, this means that creating users can bog down the test suite; happily, there is an easy fix. BCrypt uses a cost factor to control how computationally costly it is to create the secure hash. The default value is designed for security, not for speed, which is perfect for production applications, but in tests our needs are reversed: we want fast tests, and don’t care at all about the security of the test users’ password hashes. The solution is to add a few lines to the test configuration file, config/environments/test.rb, redefining the cost factor from its secure default value to its fast minimum value

  require 'bcrypt'
  silence_warnings do
    BCrypt::Engine::DEFAULT_COST = BCrypt::Engine::MIN_COST
  end

end
