Types::SectionType = GraphQL::ObjectType.define do
  name "Section"
  field :id, !types.ID
  field :name, !types.String
  field :slug, !types.String
  field :description, types.String
  field :rank, !types.Int
  field :parent_section, Types::SectionType
  field :subsections, types[Types::SectionType]
end
