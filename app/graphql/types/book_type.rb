module Types
  class BookType < Types::BaseObject
    field :id, ID, null: false
    field :title, String, null: false
    field :publication_date, Integer, null: false
    field :genre, Enums::Genre, null: false
    field :author, Types::AuthorType, null: false
  end
end
