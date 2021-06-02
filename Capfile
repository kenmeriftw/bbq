# Load DSL and Setup Up Stages

require 'capistrano/setup'
require 'capistrano/deploy'
require 'capistrano/rails'
require 'capistrano/rails/db'
require 'capistrano/bundler'
require 'capistrano/passenger'
require 'capistrano/rbenv'
require 'capistrano-resque'
require 'capistrano/setup'
require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

require 'sshkit/sudo'

set :rbenv_ruby, '2.7.2'

# Loads custom tasks from `lib/capistrano/tasks' if you have any defined.
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
