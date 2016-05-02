module ActivitiesHelper
  def activity_message(activity)
    "<a href='#{user_path(activity.followed_user)}'>"\
    "#{activity.followed_user.reference_title}"\
    "</a> has #{action_to_human(activity.action)} "\
    "<a href='#{action_to_path(activity.action, activity.item)}'>"\
    "#{activity.item.reference_title}</a>".html_safe
  end

  def action_to_human(action)
    {
      gave_props: "given props to",
      accepted_credit_invite: "credited",
      commented_on: "commented on",
      created_reel: "created a new reel",
      followed_item: "followed",
    }[action]
  end

  def action_to_path(action, item)
    case action
    when :gave_props
      reel_path(item.try(:reel), anchor: "media-#{item.id}")
    when :accepted_credit_invite
      reel_path(item)
    when :commented_on
      reel_path(item.try(:reel), anchor: "media-#{item.id}")
    when :created_reel
      reel_path(item)
    when :followed_item
      user_path(item)
    end
  end
end