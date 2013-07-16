#Конфиг деплоя на production
server 'vs01.convead.com', :app, :web, :db, :primary => true
set :branch, "master" unless exists?(:branch)
set :rails_env, "production"

