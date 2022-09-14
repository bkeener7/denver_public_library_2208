class Author
    attr_reader :author_info, :books

    def initialize(author_hash)
        @author_info = author_hash
        @books = []
    end

    def name
        "#{author_info[:first_name]} #{author_info[:last_name]}"
    end

    def write(new_title, new_publication_date)        
       new_book = Book.new({author_first_name: "#{author_info[:first_name]}", author_last_name: "#{author_info[:last_name]}", title: new_title, publication_date: new_publication_date})
       @books.push(new_book)
       new_book
    end
end