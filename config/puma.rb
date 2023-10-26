# Use at least one worker per core if you're on a multi-core machine
workers Integer(ENV['WEB_CONCURRENCY'] || 2)

# Min and Max threads per worker
threads_count = Integer(ENV['MAX_THREADS'] || 5)
threads threads_count, threads_count

# Specifies the `bind` address to use
bind "tcp://0.0.0.0:#{ENV['PORT']}"

# Specifies the `environment` to run in
environment ENV['RACK_ENV'] || 'development'

# Preload the application before starting the workers
preload_app!

# Allow puma to be restarted by `rails restart` command.
plugin :tmp_restart

# Logging
stdout_redirect 'log/puma.log', 'log/puma.log', true

# Daemonize the server into the background
daemonize true
