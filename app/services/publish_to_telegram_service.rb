class PublishToTelegramService
  def initialize(post)
    @post = post
  end

  def call
    message = "New Blog Post: \n#{@post.title}\n#{@post.articl.truncate(100)}\nRead more: #{Rails.application.routes.url_helpers.post_url(@post)}"
    begin
      TELEGRAM_BOT_CLIENT.api.send_message(chat_id: ENV["TELEGRAM_CHANNEL_ID"], text: message)
    rescue Telegram::Bot::Exceptions::ResponseError => e
      Rails.logger.error("Failed to send message to Telegram: \#{e.message}")
    end
  end
end
