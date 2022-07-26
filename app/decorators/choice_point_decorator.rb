class ChoicePointDecorator < ApplicationDecorator
  delegate_all

  # Call this when passing a choice point to the `card` partial.
  def card
    ChoicePoints::CardFormatter.new(self, helpers)
  end

  # A link to the choice point, with the choice point's title as content.
  def link(**attributes)
    h.link_to(title, self, attributes)
  end

  # A checked circle if the current user has voted on the choice point, an
  # unchecked circle otherwise.
  def vote_icon
    icon = vote_from?(h.current_user) ? 'check-circle' : 'circle'
    h.icon('far', icon)
  end

  # A solid bookmark if the current user has saved the choice point, an unfilled
  # bookmark otherwise.
  def save_icon
    icon_style = favorited_by?(h.current_user) ? 'fas' : 'far'
    h.icon(icon_style, 'bookmark')
  end

  # The appropriate vote icon, accompanied by either 'vote' or 'voted',
  # depending on whether the current user has voted on the choice point.
  def vote_button
    text = vote_from?(h.current_user) ? 'voted' : 'vote'
    h.link_to(h.safe_join([vote_icon, text], " "), self)
  end

  # The appropriate save icon, accompanied by either 'save' or 'remove',
  # depending on whether the current user has saved the choice point.
  def save_button
    return unless h.current_user

    text = h.tag.span(favorited_by?(h.current_user) ? 'remove' : 'save',
                      class: ['save-target'])
    h.link_to h.toggle_favorite_choice_point_path(self),
              remote: true, method: :post,
              data: { controller: 'favorite',
                      action: 'click->favorite#toggle' } do
      h.safe_join([save_icon, text], " ")
    end
  end

  # Formats the choice point's deadline based on the provided block.
  def deadline
    h.tag.time(yield(super()), datetime: super())
  end
end
