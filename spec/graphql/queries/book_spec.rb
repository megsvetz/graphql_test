require "rails_helper"

module Queries
  RSpec.describe Book, type: :request do
    describe "resolve" do
      it "returns book for provided id" do
        author = create(:author)
        book = create(:book, author: author, title: "Hero", publication_date: 1984, genre: "Thriller")

        post "/graphql", params: { query: query(id: book.id)}

        json = JSON.parse(response.body)
        data = json["data"]["book"]

        expect(data).to include(
          "id"              => book.id.to_s,
          "title"           => book.title,
          "publicationDate" => book.publication_date,
          "genre"           => book.genre,
          "author"          => { "id" => author.id.to_s }
        )
      end

      def query(id:)
        <<~GQL
          query {
            book(
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
