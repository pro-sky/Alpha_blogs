class ArticleMailer < ApplicationMailer
    # default from: 'sujeet.yadav@unthinkale.co'

  def new_post_notification(article_id)
    @article = Article.find(article_id)
    @subscribers = User.where(admin: true) # Assuming you have a User model with a admin attribute

    mail to: @subscribers.pluck(:email), subject: "New Post: #{@article.title}"
  end

end
