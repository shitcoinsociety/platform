require "net/http"
require "json"

namespace :background do
  desc "Send updated prices to frontend"
  task prices: :environment do
    def fetch_btc_eur_price
      # Primary: Coinbase API
      begin
        uri = URI("https://api.coinbase.com/v2/prices/BTC-EUR/spot")
        response = Net::HTTP.get_response(uri)
        if response.code == "200"
          data = JSON.parse(response.body)
          price = data["data"]["amount"].to_f
          # puts "Fetched BTC-EUR price from Coinbase: #{price}"
          return price
        end
      rescue => e
        puts "Coinbase API failed: #{e.message}"
      end

      # Fallback 1: CoinGecko API
      begin
        uri = URI("https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=eur")
        response = Net::HTTP.get_response(uri)
        if response.code == "200"
          data = JSON.parse(response.body)
          price = data["bitcoin"]["eur"].to_f
          # puts "Fetched BTC-EUR price from CoinGecko: #{price}"
          return price
        end
      rescue => e
        puts "CoinGecko API failed: #{e.message}"
      end

      # Fallback 2: CryptoCompare API
      begin
        uri = URI("https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=EUR")
        response = Net::HTTP.get_response(uri)
        if response.code == "200"
          data = JSON.parse(response.body)
          price = data["EUR"].to_f
          # puts "Fetched BTC-EUR price from CryptoCompare: #{price}"
          return price
        end
      rescue => e
        puts "CryptoCompare API failed: #{e.message}"
      end

      # If all APIs fail, return nil
      puts "All API sources failed, unable to get BTC-EUR price"
      nil
    end

    while true
      begin
        btc_eur = fetch_btc_eur_price

        if btc_eur.nil?
          puts "No BTC-EUR price available from APIs, skipping this cycle"
          sleep 30
          next
        end

        sat_eur = btc_eur.to_r / 100_000_000.to_r

        Price.create do |price|
          price.base = "sat"
          price.quote = "eur"
          price.value = sat_eur
          price.save!
        end

        Price.where("delete_at < ?", Time.now.utc).delete_all

        sleep 3
      rescue => e
        puts "Error updating prices: #{e.message}"
        puts e.backtrace.first(5).join("\n") # Show stack trace for debugging
        sleep 10
      end
    end
  end
end
