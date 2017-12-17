class Resolvers::GetTopRankedArticles < GraphQL::Function

  argument :section_id, !types.ID
  argument :limit, types.Int
  # return type from the mutation
  type types[Types::ArticleType]

  # the mutation method
   # _obj - is parent object, which in this case is nil
  # _args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  def call(_obj, args, _ctx)
    articles =
      Article
        .joins("JOIN sections ON articles.section_id = sections.id")
        .order("articles.rank + 3 * sections.rank + 12 * articles.issue"\
               " + 192 * articles.volume DESC")
        .where(section_id: args["section_id"])
    articles = articles.limit(args["limit"]) if args["limit"]
    return articles
  end
end