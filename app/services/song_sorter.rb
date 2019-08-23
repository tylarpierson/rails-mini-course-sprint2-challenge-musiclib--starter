class SongSorter
    def initialize(songs, sort_value)
        @songs = songs
        @sort_value = sort_value
    end

    def sort 
        if sort_value == "random"
           songs.shuffle
          elsif sort_value == "reverse"
            songs.reverse
          else
            songs
        end
    end
end