module Queries
  class Authors < Queries::BaseQuery
    description "Return list of all authors"

    type [Types::AuthorType], null: false

    def resolve
      ::Author.all
    end
  end
end
