web: bundle exec puma -p $PORT -C config/puma.rb
release: rake db:migrate; rake db:seeds SEED_FILE='load_department'; rake db:seeds SEED_FILE='additional'; rake db:seeds SEED_FILE='2019_01_08'; rake db:seeds SEED_FILE='advisory'
