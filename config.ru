# This file is used by Rack-based servers to start the application.

require_relative 'config/environment'

run Rails.application

use Rack::ReverseProxy do
reverse_proxy(/^\/blog(\/.*)$/, 'https://blog.hellocarbo.com$1', opts = { preserve_host: true })
end
