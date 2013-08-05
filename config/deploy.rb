require "bundler/capistrano"

set :application, "pontos"
set :repository,  "https://github.com/nerde/pontos.git"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names

set :deploy_to, "/var/www/#{application}"
set :user, 'root'
set :use_sudo, false
set :normalize_asset_timestamps, false

set :bundle_flags, "--deployment --quiet --binstubs"
set :default_environment, {
  'PATH' => "$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
}

role :web, "caronero.com.br"                          # Your HTTP server, Apache/etc
role :app, "caronero.com.br"                          # This may be the same as your `Web` server
role :db,  "caronero.com.br", :primary => true # This is where Rails migrations will run

after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml.example"),
        "#{shared_path}/config/database.yml"
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/initializers/secret_token.rb #{release_path}/config/initializers/secret_token.rb"
  end
  after "deploy:finalize_update", "deploy:symlink_config"
end
