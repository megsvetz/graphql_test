require "rails_helper"

module Queries
  RSpec.describe Books, type: :request do
    describe "resolve" do
      it "returns all books" do
        author = create(:author)
        book_1 = create(:book, author: author, title: "Hero", publication_date: 1984, genre: "Thriller")
        book_2 = create(:book, author: author, title: "Nightmares in the Sky", publication_date: 1988, genre: "Horror")

        post "/graphql", params: { query: query }

        json = JSON.parse(response.body)
        data = json["data"]["books"]


        expect(data).to match_array [
          hash_including(
            "id"               => book_1.id.to_s,
            "title"            => book_1.title,
            "publicationDate"  => book_1.publication_date,
            "genre"            => book_1.genre,
            "author"           => { "id" => author.id.to_s }
          ),
          hash_including(
            "id"               => book_2.id.to_s,
            "title"            => book_2.title,
            "publicationDate"  => book_2.publication_date,
            "genre"            => book_2.genre,
            "author"           => { "id" => author.id.to_s }
          )
        ]
      end
    end

    def query
      <<~GQL
        query {
          books {
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
