set :stages, %w(production staging)
set :default_stage, "staging"
require 'capistrano/ext/multistage'

#Приложение
set :application, "widget.convead.com"

#Репозиторий
set :scm, :git
set :repository,  'git@github.com:BrandyMint/icrm-client.git'
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true

#Учетные данные на сервере
set :user,      'wwwicrm'
set :deploy_to,  defer { "/home/#{user}/#{application}" }
set :use_sudo,   false

set :keep_releases, 3

set :rbenv_ruby_version, "2.0.0-p195"
set :bundle_flags, "--deployment --quiet --binstubs"

after 'deploy', 'bower:install'
after 'bower', "deploy:cleanup"

namespace :bower do
  desc "Installing bower components"
  task :install do
    run "cd #{latest_release} && bower install"
  end
end


require "bundler/capistrano"
require "capistrano-rbenv"
require "recipes0/init_d/unicorn"
require "recipes0/nginx"

