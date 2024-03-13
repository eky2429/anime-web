require "sinatra"
require "sinatra/reloader"
require "http"
require "./anime"


def is_recent(date)
  #Includes only animes past this date
  recent_year = 2020
  array = date.split("-")
  Integer(array[0]) >= recent_year
end

def get_anime_info()
  official_anime_hash = {}
  anime_text = ""

  offset = 180
  link = "https://kitsu.io/api/edge/anime?fields%5Banime%5D=startDate%2CendDate%2CcanonicalTitle%2CaverageRating&sort=-startDate&page%5Blimit%5D=10&page%5Boffset%5D=#{offset}"
  anime_info = HTTP.get(link)
  anime_hash = JSON.parse(anime_info)
  anime_data = anime_hash.fetch("data")

  #Gets 10 animes in which they are "recent"
  anime_data.each { |item|
    start_date = item.dig("attributes", "startDate")
    end_date = item.dig("attributes", "endDate")
    anime_name = item.dig("attributes", "canonicalTitle")
    anime_rating = item.dig("attributes", "averageRating")
    if (anime_rating == nil) 
      anime_rating = "Unknown"
    end
    anime_object = AnimeObject.new(start_date, end_date, anime_rating)
    official_anime_hash[anime_name] = anime_object
  }

  #Sorts the animes by ratings
  official_anime_hash = official_anime_hash.sort_by do |key, value|
    value.get_rating()
  end
  official_anime_hash.reverse!

  #Creates text based on ordered hash elements
  official_anime_hash.each {
    |key, value|
    anime_text += "<h2>#{key}</h2><p>Starting date: #{value.get_start_date()}</p>"
    anime_text += "<p>End date: #{value.get_end_date()}</p>" if value.get_end_date() != nil
    anime_text += "<p>Rating: #{value.get_rating}</p>"
  }
  anime_text
end

get("/") do
  anime_elements = get_anime_info()
  "
  <h1>Top 10 animes that came out recently or will be coming out</h1>
  <p>The list is shown below: </p>
  #{anime_elements}"
end
