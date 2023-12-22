require 'simplecov'

if ENV['CI']
  SimpleCov.start('rails') do
    if ENV['COVERAGE']
      require 'simplecov-lcov'

      SimpleCov::Formatter::LcovFormatter.config do |c|
        c.report_with_single_file = true
        c.single_report_path = 'coverage/lcov.info'
      end

      formatter SimpleCov::Formatter::LcovFormatter

    end

    add_filter ['version.rb', 'initializer.rb', 'config.rb']
  end
end

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

module ActiveSupport
  class TestCase
    Capybara.server_host = '0.0.0.0'
    Capybara.app_host = "http://#{ENV.fetch('HOSTNAME')}:#{Capybara.server_port}"

    # Run tests in parallel with specified workers
    ENV['RAILS_ENV'] || parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  end
end

class ActionDispatch::IntegrationTest
  def login_as(user)
    if respond_to?(:visit)
      visit(login_url)
      fill_in(:name, with: user.name)
      fill_in(:password, with: 'secret')
      click_on('Login')
    else
      post(login_url, params: { name: user.name, password: 'secret' })
    end
  end

  def logout
    delete(logout_url)
  end

  def setup
    login_as(users(:one))
  end
end
