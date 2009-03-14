set :user, "bolongu"
set :domain, "bolongu.com"
set :application, "bolongu"

default_run_options[:pty] = true
set :scm_user, "marano"
set :scm_password, Proc.new { Capistrano::CLI.password_prompt "Git Password for marano: "}
set :repository,  "git@github.com:marano/bolongu.git" 
set :scm, :git
set :deploy_via, :remote_cache
set :remote, scm_user
set :scm_verbose, true
set :branch, 'master'
set :git_repo, "/home/#{user}/repo/${application}/marano.git"
set :git_enable_submodules, 1
set :git_shallow_clone, 1

role :web, domain
role :app, domain
role :db, domain
 
set :deploy_to, "/home/#{user}/rails_app/#{application}"
set :public_html, "/home/#{user}/public_html"
set :site_path, "#{public_html}/#{application}"
set :runner, nil
set :use_sudo, false
set :no_release, true
 
set :copy_exclude, %w(.git/* .svn/* log/* tmp/* .gitignore)
set :keep_releases, 5

ssh_options[:forward_agent] = true
ssh_options[:username] = user
ssh_options[:paranoid] = false

######################################### Copied from Locarails ########################################

desc "Garante que as configuracoes estao adequadas"
task :before_setup do
  ts = Time.now.strftime("%y%m%d%H%M%S")
  
  #Cria a pasta /rails_app
  run "test -d /home/#{user}/rails_app || mkdir -m 755 /home/#{user}/rails_app"
  #Se já existe a pasta deploy_to, então é movida para backup
  run "if [ -d #{deploy_to} ]; then mv #{deploy_to} #{deploy_to}-#{ts}.old ; fi"
  #Cria a pasta deploy_to
  run "test -d #{deploy_to} || mkdir -m 755 #{deploy_to}"
  #Cria a pasta /etc
  run "test -d #{deploy_to}/etc || mkdir -m 755 #{deploy_to}/etc"
  #Se já existe a pasta site_path, então é movida para backup
  run "if [ -d #{site_path} ]; then mv #{site_path} #{site_path}-#{ts}.old ; fi"
  #Se já existe a pasta site_path, então é movida para backup
  run "if [ -h #{site_path} ]; then mv #{site_path} #{site_path}-#{ts}.old ; fi"
  #É criado o link em public para apontar para o public da aplicação
  run "ln -s #{deploy_to}/current/public #{public_html}/#{application}"
  upload File.join(File.dirname(__FILE__), "database_production.yml"), "#{deploy_to}/etc/database.yml"
  upload File.join(File.dirname(__FILE__), "initializers/mail_config.rb"), "#{deploy_to}/etc/mail_config.rb"
  #upload File.join(File.dirname(__FILE__), "locaweb_backup.rb"), "#{deploy_to}/etc/locaweb_backup.rb"
  #upload File.join(File.dirname(__FILE__), "ssh_helper.rb"), "#{deploy_to}/etc/ssh_helper.rb"  
end

desc "Garante que o database.yml foi corretamente configurado"
task :before_symlink do
  on_rollback {}
  run "test -d #{release_path}/tmp || mkdir -m 755 #{release_path}/tmp"
  run "test -d #{release_path}/db || mkdir -m 755 #{release_path}/db"
  #Copia também a configuração do email de envio
  run "cp #{deploy_to}/etc/mail_config.rb #{release_path}/config/initializers/mail_config.rb"
  run "cp #{deploy_to}/etc/database.yml #{release_path}/config/database.yml"  
  run "cd #{release_path} && rake db:migrate RAILS_ENV=production"
end

namespace :deploy do
  desc "Pede restart ao servidor Passenger"
  task :restart, :roles => :app do
    run "chmod -R 755 #{release_path}"
    run "touch #{deploy_to}/current/tmp/restart.txt"    
  end
end

namespace :log do
  desc "tail production log files" 
  task :tail, :roles => :app do
    run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
      puts  # para uma linha extra 
      puts "#{channel[:host]}: #{data}" 
      break if stream == :err    
    end
  end
end

namespace :ssh do
  desc "Faz upload da sua chave publica"
  task :upload_key, :roles => :app do
    public_key_path = File.expand_path("~/.ssh/id_rsa.pub")
    unless File.exists?(public_key_path)
      puts %{
        Chave publica nao encontrada em #{public_key_path}
        Crie sua chave - sem passphrase - com o comando:
          ssh_keygen -t rsa
      }
      exit 0
    end
    ssh_path = "/home/#{user}/.ssh"
    run "test -d #{ssh_path} || mkdir -m 755 #{ssh_path}"
    upload public_key_path, "#{ssh_path}/../id_rsa.pub"
    run "test -f #{ssh_path}/authorized_keys || touch #{ssh_path}/authorized_keys"
    run "cat #{ssh_path}/../id_rsa.pub >> #{ssh_path}/authorized_keys"
    run "chmod 755 #{ssh_path}/authorized_keys"
  end
end
