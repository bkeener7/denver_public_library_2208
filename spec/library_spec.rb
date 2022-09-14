require 'rspec'
require './lib/book'
require './lib/author'
require './lib/library'

RSpec.describe Library do
    before(:each) do
        @dpl = Library.new("Denver Public Library")
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
        charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
        jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
        professor = charlotte_bronte.write("The Professor", "1857")
        villette = charlotte_bronte.write("Villette", "1853")
        
        harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
        mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

        @dpl.add_author(charlotte_bronte)
        @dpl.add_author(harper_lee)

        expect(@dpl.authors).to include(charlotte_bronte, harper_lee)
        expect(@dpl.books).to include(jane_eyre, professor, villette, mockingbird)
    end

    it '6. can see publication time frame for authors' do
        charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
        jane_eyre = charlotte_bronte.write("Jane Eyre", "October 16, 1847")
        professor = charlotte_bronte.write("The Professor", "1857")
        villette = charlotte_bronte.write("Villette", "1853")
        
        harper_lee = Author.new({first_name: "Harper", last_name: "Lee"})
        mockingbird = harper_lee.write("To Kill a Mockingbird", "July 11, 1960")

        @dpl.add_author(charlotte_bronte)
        @dpl.add_author(harper_lee)     

        expect(@dpl.publication_time_frame_for(charlotte_bronte)).to eq({:start=>"1847", :end=>"1857"})
        expect(@dpl.publication_time_frame_for(harper_lee)).to eq({:start=>"1960", :end=>"1960"})
    end
end