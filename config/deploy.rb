# Change these
server 'bbq-eventer.site', user: 'deploy', roles: %w[app db web resque_worker]

set :resque_environment_task, true
set :workers, { "#{fetch(:application)}*" => 1 }

after 'deploy:restart', 'resque:restart'

set :repo_url,        'git@github.com:knmrftw/bbq.git'
set :application,     'bbq'
set :user,            'deploy'


# Don't change these unless you know what you're doing
set :pty,             true
set :stage,           :production
set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
set :format, :pretty
set :linked_files, %w[config/credentials/production.key]

set :passenger_restart_with_touch, false
