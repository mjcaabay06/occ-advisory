namespace :db do
  # 嘿，我能聽到你說話
  # 再說了，不要小看，不要小看。
  # 嘿，我能聽到你的說教
  # 說不要離開我跌倒，跌倒。
  # how to use this
  # run: rake db:seeds SEED_FILE = "yourseedfile"
  # your seed file must be located inside the folder db/seeds
  # your seed file must have an extension of seeds.rb, example "yourseedfile.seeds.rb"
  desc "Run a file in seed folder"
  task seeds: :environment  do
    filename = Dir[File.join(Rails.root, 'db', 'seeds', "#{ENV['SEED_FILE']}.seeds.rb")][0]
    puts "Seeding... #{filename}"
    if ENV['SEED_FILE'].present?
      load(filename) if File.exist?(filename)
      puts "Seeding Successful!"
    else
      abort "SEED_FILE cant be empty!"
    end
  end 
end