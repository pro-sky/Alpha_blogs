module ReactionsHelper
  def update_reaction_js(reactionable, user_reaction)
    js = <<-JS
      document.querySelector('.like-count-#{reactionable.id}').innerHTML = '#{reactionable.like_count}';
      if (#{user_reaction.present?}) {
        document.querySelector('.#{reactionable.class.name.downcase}-reaction-link-#{reactionable.id}').outerHTML = '#{j render(partial: "reactions/unlike_button", locals: { reactionable: reactionable, user_reaction: user_reaction })}';
      } else {
        document.querySelector('.#{reactionable.class.name.downcase}-reaction-link-#{reactionable.id}').outerHTML = '#{j render(partial: "reactions/like_button", locals: { reactionable: reactionable })}';
      }
    JS
    js.html_safe
  end
end
