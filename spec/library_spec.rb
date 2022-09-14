require 'rspec'
require './lib/book'
require './lib/author'
require './lib/library'

RSpec.describe Library do
    before(:each) do
        @dpl = Library.new("Denver Public Library")

        @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
        @jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
        @professor = @charlotte_bronte.write("The Professor", "1857")
        @villette = @charlotte_bronte.write("Villette", "1853")
        
        @harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
        @mockingbird = @harper_lee.write("To Kill a Mockingbird", "July 11, 1960")
    end

    it '1. exists' do
        expect(@dpl).to be_an_instance_of(Library)
    end

    it '2. has a name' do
        expect(@dpl.name).to eq("Denver Public Library")
    end

    it '3. has no books by default' do
        expect(@dpl.books).to eq([])
    end

    it '4. has no authors by default' do
        expect(@dpl.authors).to eq([])
    end

    it '5. can add authors and their books' do
        @dpl.add_author(@charlotte_bronte)
        @dpl.add_author(@harper_lee)

        expect(@dpl.authors).to include(@charlotte_bronte, @harper_lee)
        expect(@dpl.books).to include(@jane_eyre, @professor, @villette, @mockingbird)
    end

    it '6. can see publication time frame for authors' do
        @dpl.add_author(@charlotte_bronte)
        @dpl.add_author(@harper_lee)     

        expect(@dpl.publication_time_frame_for(@charlotte_bronte)).to eq({:start=>"1847", :end=>"1857"})
        expect(@dpl.publication_time_frame_for(@harper_lee)).to eq({:start=>"1960", :end=>"1960"})
    end

    it '7. cannot checkout books not in library' do
        expect(@dpl.checkout(@mockingbird)).to eq(false)
        expect(@dpl.checkout(@jane_eyre)).to eq(false)
    end

    it '8. can checkout books in the library' do
        @dpl.add_author(@charlotte_bronte)
        expect(@dpl.checkout(@jane_eyre)).to eq(true)
    end

    it '9. keeps a list of checked-out books' do
        @dpl.add_author(@charlotte_bronte)
        @dpl.checkout(@jane_eyre)

        expect(@dpl.checked_out_books).to eq([@jane_eyre])
    end

    it '10. cannot checkout books that are currently checked-out' do
        @dpl.add_author(@charlotte_bronte)
        @dpl.checkout(@jane_eyre)

        expect(@dpl.checkout(@jane_eyre)).to eq(false)
    end

    it '11. can return books and check them back out' do
        @dpl.add_author(@charlotte_bronte)
        @dpl.checkout(@jane_eyre)
        @dpl.return(@jane_eyre)

        expect(@dpl.checked_out_books).to eq([])
        expect(@dpl.checkout(@jane_eyre)).to eq(true)
    end

    it '12. tracks most popular book' do
        @dpl.add_author(@charlotte_bronte)
        @dpl.add_author(@harper_lee)
        @dpl.checkout(@jane_eyre)
        @dpl.return(@jane_eyre)
        @dpl.checkout(@jane_eyre)
        @dpl.checkout(@villette)

        expect(@dpl.checked_out_books).to include(@jane_eyre, @villette)
        
        3.times { @dpl.checkout(@mockingbird); @dpl.return(@mockingbird) }   
        
        expect(@dpl.most_popular_book).to eq(@mockingbird)
    end
end