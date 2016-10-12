module Reminder
  class ReminderViewHook < Redmine::Hook::ViewListener
    def view_layouts_base_body_bottom(context={})
      if context[:controller] && (context[:controller].is_a?(MyController))
        <<-SRC
        <script type='text/javascript'>
        (function ($) {
          $(function () {
            $('#pref_no_self_notified').parent().parent().append($('#reminder_notification'));
          });
        })(jQuery);
        </script>
        SRC
      end
    end

    def view_my_account(context={})
      <<-SRC
      <p id='reminder_notification'>
        #{context[:form].text_field :reminder_notification, :required => true, :size => 10,
                                    :value => context[:user].reminder_notification,
                                    :style => 'margin-left:5px'}
        <br/>
        <small><em>#{label_tag 'text_comma_separated', l(:text_comma_separated)}</em></small>
      </p>
      SRC
    end
  end
end
