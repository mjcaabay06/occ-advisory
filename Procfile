web: bundle exec puma -p $PORT -C config/puma.rb
release: rake db:migrate; rake db:seeds SEED_FILE='2019_01_08'
