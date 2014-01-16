require 'rvm/capistrano'
require 'bundler/capistrano'


# application name and repository
set :application, "utour"
set :repository,  "git@github.com:Synbios/utour.git"

# deploy path
set :deploy_to, "/var/www/utour"

# use git
set :scm, :git
set :branch, "master"

# host information
server "106.186.121.195", :app, :web, :db, :primary => true
set :user, "deploy"
# not required if use a RSA
# set :scm_passphrase, "password"
set :use_sudo, false
set :rails_env, "production"
set :asset_env, "RAILS_GROUPS=assets DATABASE_URL=mysql2://user:root@127.0.0.1/."
set :deploy_via, :copy
# set :deploy_via, :remote_cache
set :keep_releases, 1

# SSH options
ssh_options[:forward_agent] = true
# set :ssh_options, { :forward_agent => true, :port => 4321 }
default_run_options[:pty] = true # show password prompt in terminal if needed






#set :rvm_type, :system





namespace :deploy do
  desc "Symlink shared/* files"
    task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

#  desc "Symlink shared config files"
#  	task :symlink_config_files do
#    run "#{ try_sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
#  end

  desc "Restart Passenger app"
    task :restart do
    run "#{ try_sudo } touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
  end
end

after "deploy:update_code", "deploy:symlink_shared"
#after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"
# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# only if database is on a different host
# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end