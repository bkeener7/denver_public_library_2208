class Library
    attr_reader :name, :books, :authors, :checked_out_books

    def initialize(name)
        @name = name
        @books = []
        @authors = []
        @checked_out_books = []
        @times_checked_out = Hash.new(0)
    end

    def add_author(author)
        authors.push(author)
        books.push(author.books).flatten!
    end

    def publication_time_frame_for(author)        
       pub_years = author.books.map { |book| book.publication_year }
       {start: pub_years.min, end: pub_years.max}           
    end

    def checkout(book)
      if books.include?(book)
        checked_out_books.push(book)
        @times_checked_out[book] += 1
        books.delete(book)
        true
      else 
        false
      end
    end

    def return (book)
        books.push(book)
        checked_out_books.delete(book)
    end

    def most_popular_book
        @times_checked_out.max_by { |books, checkouts| checkouts }.first
    end    
end