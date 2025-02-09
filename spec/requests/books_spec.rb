require 'rails_helper'

RSpec.describe "Books", type: :request do
  describe "POST /books" do
    
    context "when the book is valid" do
      it "creates a new book and shows a success flash message" do
        expect {
          post books_path, params: { book: { 
            title: "The Great Gatsby", 
            author: "F. Scott Fitzgerald", 
            price: 10.99, 
            published_date: "1925-04-10" 
          } }
        }.to change(Book, :count).by(1)

        follow_redirect!
        expect(response.body).to include("Book was successfully created.")
      end
    end

    context "when the book is invalid" do
      it "fails to create a book without an author" do
        expect {
          post books_path, params: { book: { 
            title: "The Great Gatsby", 
            author: "", 
            price: 10.99, 
            published_date: "1925-04-10" 
          } }
        }.not_to change(Book, :count)

        expect(response.body).to include("Author can&#39;t be blank") # Escaped HTML
      end

      it "fails to create a book without a price" do
        expect {
          post books_path, params: { book: { 
            title: "The Great Gatsby", 
            author: "F. Scott Fitzgerald", 
            price: nil, 
            published_date: "1925-04-10" 
          } }
        }.not_to change(Book, :count)

        expect(response.body).to include("Price can&#39;t be blank")
      end

      it "fails to create a book with a negative price" do
        expect {
          post books_path, params: { book: { 
            title: "The Great Gatsby", 
            author: "F. Scott Fitzgerald", 
            price: -5, 
            published_date: "1925-04-10" 
          } }
        }.not_to change(Book, :count)

        expect(response.body).to include("Price must be greater than or equal to 0")
      end

      it "fails to create a book without a published date" do
        expect {
          post books_path, params: { book: { 
            title: "The Great Gatsby", 
            author: "F. Scott Fitzgerald", 
            price: 10.99, 
            published_date: nil 
          } }
        }.not_to change(Book, :count)

        expect(response.body).to include("Published date can&#39;t be blank")
      end
    end
  end
end
