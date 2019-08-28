require "rails_helper"

module Queries
  RSpec.describe Author, type: :request do
    describe "resolve" do
      it "returns author for provided id" do
        author = create(:author)
        book = create(:book, author: author)

        post "/graphql", params: { query: query(id: author.id) }
        json = JSON.parse(response.body)
        data = json["data"]["author"]

        expect(data).to include(
          "id"          => author.id.to_s,
          "dateOfBirth" => author.date_of_birth.to_s,
          "firstName"   => author.first_name,
          "lastName"    => author.last_name,
          "books"       => [{ "id" => book.id.to_s }]
        )
      end

      def query(id:)
        <<~GQL
          query {
            author(
              id: #{id}
            ) {
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
end
