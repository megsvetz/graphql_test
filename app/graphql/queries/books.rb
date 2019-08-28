module Queries
  class Books < Queries::BaseQuery
    description "Return list of all books"

    type [Types::BookType], null: false

    def resolve
      ::Book.all
    end
  end
end
