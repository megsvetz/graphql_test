require "rails_helper"

module Mutations
  module Books
    RSpec.describe DestroyBook, type: :request do
      describe "resolve" do
        it "destroys a book" do
          book = create(:book)

          expect do
            post "/graphql", params: { query: query(id: book.id) }
          end.to change { Book.count }.by(-1)
        end

        it "returns a book" do
          book = create(:book)
          
          post "/graphql", params: { query: query(id: book.id) }
          json = JSON.parse(response.body)
          data = json["data"]["destroyBook"]

          expect(data).to include(
            "id"              => book.id.to_s,
            "title"           => book.title,
            "publicationDate" => book.publication_date,
            "genre"           => book.genre,
            "author"          => { "id" => book.author.id.to_s }
          )
        end

        def query(id:)
          <<~GQL
            mutation {
              destroyBook(
                id: #{id}
              ) {
                id
                title
                publicationDate
                genre
                author {
                  id
                }
              }
            }
          GQL
        end  
      end
    end
  end
end
