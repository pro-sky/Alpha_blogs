class NotifyWorker
  include Sidekiq::Worker

  def perform(article_id)
    # article = Article.find(article_id)
    ArticleMailer.new_post_notification(article_id).deliver_now
    # Logic to send email notifications for the post
  end
end
