require 'capistrano_colors'

set :domain, "188.226.158.112"
server '188.226.158.112', :app, :web, :db, primary: true

set :branch, "master"

role :web, domain
role :app, domain
role :db,  domain, primary: true

ssh_options[:forward_agent] = true
default_run_options[:pty] = true

set :application, "sse_chat_simple"
set :app_name, application
set :deploy_to, "/var/www/#{application}"
set :user,        'root'
set :use_sudo,    false

set :scm, :git
set :repository,  "git@github.com:alterego-labs/sse_chat_simple.git"
set :deploy_via, :remote_cache

after 'deploy:finalize_update', 'deploy:ex_layer:install_dependencies'

namespace :deploy do
  namespace :ex_layer do
    desc "Install dependencies"
    task :install_dependencies do
      run "cd #{release_path} && MIX_ENV=prod mix deps.get"
      run "cd #{release_path} && MIX_ENV=prod mix deps.compile"
    end
  end
end
