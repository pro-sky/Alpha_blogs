module ApplicationHelper
    def bootstrap_alert_class(name)
        case name.to_sym
        when :success
          'alert-success'
        when :error, :danger
          'alert-danger'
        when :alert, :warning
          'alert-warning'
        when :notice
            'alert-success'
        else
          'alert-secondary'
        end
      end
    









end
