module Types
  class QueryType < Types::BaseObject
    field :authors, resolver: Queries::Authors
    field :author, resolver: Queries::Author
    field :books, resolver: Queries::Books
    field :book, resolver: Queries::Book
  end
end
