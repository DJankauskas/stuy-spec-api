class Resolvers::GetLatestArticles < Resolvers::ArticleQueryFunction

  argument :section_id, types.ID
  argument :offset, types.Int
  argument :limit, types.Int
  argument :include_subsections, types.Boolean

  # return type from the mutation
  type types[!Types::ArticleType]

  # the mutation method
  # _obj - is parent object, which in this case is nil
  # _args - are the arguments passed
  # _ctx - is the GraphQL context (which would be discussed later)
  def call(_obj, args, _ctx)
    articles = Article.order(created_at: :desc).published

    if args['section_id'] && args['include_subsections']
      # NOTE: only works with one level of nesting
      # Fix if multiple levels of nesting introduced
      subsection_ids = Section.find(args['section_id']).subsections.map do |s| s.id end
      subsection_ids << args['section_id']
      articles = articles.where(section_id: subsection_ids)
    elsif args['section_id']
      articles = articles.where(section_id: args['section_id'])
    end

    articles = articles.offset(args['offset']) if args['offset']
    articles = articles.limit(args['limit']) if args['limit']
    
    return articles
  end
end
