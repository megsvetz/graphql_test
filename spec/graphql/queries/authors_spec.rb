require "rails_helper"

module Queries
  RSpec.describe Authors, type: :request do
    describe "resolve" do
      it "returns all authors" do
        author_1 = create(:author, first_name: 'Lee', last_name: 'Child', date_of_birth: Date.parse('1954-10-29'))
        author_2 = create(:author, first_name: 'Stephen', last_name: 'King', date_of_birth: Date.parse('1947-09-21'))
        book = create(:book, author: author_1)

        post "/graphql", params: { query: query }

        json = JSON.parse(response.body)
        data = json["data"]["authors"]

        expect(data).to match_array [
          hash_including(
            "id"          => author_1.id.to_s,
            "firstName"   => author_1.first_name,
            "lastName"    => author_1.last_name,
            "dateOfBirth" => author_1.date_of_birth.to_s,
            "books"       => [{ "id" => book.id.to_s }]
          ),
          hash_including(
            "id"          => author_2.id.to_s,
            "firstName"   => author_2.first_name,  
            "lastName"    => author_2.last_name,
            "dateOfBirth" => author_2.date_of_birth.to_s,
            "books"       => []
          )
        ]
      end
    end

    def query
      <<~GQL
        query {
          authors {
            id
            firstName
            lastName
            dateOfBirth
            books {
              id
            }
          }
        }
      GQL
    end
  end
end
