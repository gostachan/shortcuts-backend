namespace :secret do
  desc "Generate a secret key base"
  task generate: :environment do
    puts SecureRandom.hex(64)
  end
end
