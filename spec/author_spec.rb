require 'rspec'
require './lib/book'
require './lib/author'

RSpec.describe Author do
    before(:each) do
        @charlotte_bronte = Author.new({first_name: "Charlotte", last_name: "Bronte"})
    end

    it '1. exists' do
        expect(@charlotte_bronte).to be_an_instance_of(Author)
    end

    it '2. has a name' do
        expect(@charlotte_bronte.name).to eq("Charlotte Bronte")
    end

    it '3. has no books by default' do
        expect(@charlotte_bronte.books).to eq([])
    end

    it '4. can write books to the book class' do
        jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
        
        expect(jane_eyre.class).to eq(Book)
        expect(jane_eyre.title).to eq("Jane Eyre")                
    end

    it '5. adds written books to books collection' do
        jane_eyre = @charlotte_bronte.write("Jane Eyre", "October 16, 1847")
        villette = @charlotte_bronte.write("Villette", "1853")

        expect(@charlotte_bronte.books).to include(jane_eyre, villette)
    end
end