namespace :scraper do
  desc "Fetch top 100 sites from Alexa"
  task alexa: :environment do
    Scraper::Alexa.run
  end
end

