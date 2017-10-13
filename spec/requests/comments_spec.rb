require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "GET /comments" do
    it "works! (now write some real specs)" do
      get comments_path
      expect_json_types(
        '*',
        article_id: :integer,
        user_id: :integer,
        content: :string
      )
    end
  end

  describe "POST /comments" do
    it "creates a new comment" do
      article = Article.first
      user = User.first
      post comments_path,
           params: {
             comment: {
               article_id: article.id,
               user_id: user.id,
               content: "This is my comment"
             }
           }
    end
  end
end
