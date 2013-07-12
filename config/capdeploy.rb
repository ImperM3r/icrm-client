#Приложение
set :application, "widget.icrm.icfdev.ru"

#Репозиторий
set :scm, :git
set :repository,  'git@github.com:BrandyMint/icrm-client.git'
set :deploy_via, :remote_cache
ssh_options[:forward_agent] = true

#Учетные данные на сервере
set :user,      'wwwicrm'
set :deploy_to,  defer { "/home/#{user}/#{application}" }
set :use_sudo,   false

server 'icfdev.ru', :app, :web, :db, :primary => true

set(:current_branch) { `git branch`.match(/\* (\S+)\s/m)[1] || raise("Couldn't determine current branch") }
set :branch, defer { current_branch } unless exists?(:branch)

set :rails_env, "development"

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

