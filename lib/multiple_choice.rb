class MultipleChoice
    attr_accessor :content, :artist, :answer, :score
    @@all = []

    def initialize(artist)
        @artist = artist
        @content = "Choose #{artist.name}'s song!"
    end

    def set_question_and_check
        menu = TTY::Prompt.new
        @answer = @artist.top_x_tracks(10).shuffle.first #random album name string
        question = []
        question << @answer
        question << get_another_artists_song
        dropdown = question.flatten!.shuffle

        selection = menu.select(" 🎧  #{@content}") do |q|
            q.choice "#{dropdown[0]}"
            q.choice "#{dropdown[1]}"
            q.choice "#{dropdown[2]}"
            q.choice "#{dropdown[3]}"
            q.choice "#{dropdown[4]}"
        end

        if selection == @answer
            brk
            $current_user.score += 3
            puts Rainbow("Correct! You got 3 point!").green
            sleep 2
        else
            brk
            puts Rainbow("Wrong! It was #{@answer}!").red
            sleep 2
        end
    end

    def get_another_artists_song
        get_artists = get_top_artists_names
        get_artists.delete(@artist.name)
        get_artists = get_artists.shuffle.first(4).map{|name| Artist.new(name: name)}
        get_artists.map {|s| s.top_x_tracks(5).compact.shuffle.first}
    end

end
