set :application, 'comfort-davines'
set :repo_url, 'git@github.com:hackers-jp/comfort-davines.git'

set :branch, proc { `git rev-parse HEAD`.chomp }

set :deploy_to, '/var/www/comfort-davines'
set :scm, :scm
set :deploy_via, :rsync

set :rsync_options, %w[
  --recursive --delete --delete-excluded
  --exclude .git*
  --exclude /config/database.yml
  --exclude /test/***
]

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml .env}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets public/system}

# rbenv
set :rbenv_type, :system
set :rbenv_ruby, '2.0.0-p353'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value

# set :default_env, { path: "/opt/ruby/bin:$PATH" }
set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    invoke 'unicorn:restart'
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  after :finishing, 'deploy:cleanup'

end

namespace :rsync do
  task :stage => %w[create_stage] do
    Dir.chdir fetch(:rsync_stage) do
      update = %W[git fetch --quiet --all --prune]
      Kernel.system *update

      checkout = %W[git reset --hard #{fetch(:branch)}]
      Kernel.system *checkout
    end
  end
end

task :precompile do
  Dir.chdir fetch(:rsync_stage) do
    system "rake", "assets:precompile"
  end
end
after "rsync:stage", "precompile"
