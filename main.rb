require "./anime"

anime_object = AnimeObject.new("12/23/1023", "23/23/3242", 42)

puts "Anime rating: #{anime_object.get_rating}"
