class Library

    attr_reader :name, :books, :authors

    def initialize(name)
        @name = name
        @books = []
        @authors = []
    end

    def add_author(author)
        authors.push(author)
        books.push(author.books).flatten!
    end

    def publication_time_frame_for(author)        
       pub_years = author.books.map { |book| book.publication_year }
       {start: pub_years.min, end: pub_years.max}           
    end
end