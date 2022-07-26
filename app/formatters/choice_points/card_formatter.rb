module ChoicePoints
  class CardFormatter < ApplicationFormatter
    def initialize(choice_point, helper_proxy)
      @choice_point = choice_point
      super(helper_proxy)
    end

    def pre_heading
      "posted by #{@choice_point.user.name}"
    end

    def heading
      @choice_point.link
    end

    def content
      h.truncate(@choice_point.description, length: 116)
    end

    def image
      h.calendarize(@choice_point.deadline do |deadline|
        deadline.strftime("%b %d")
      end)
    end

    def buttons
      [@choice_point.vote_button, @choice_point.save_button]
    end
  end
end
