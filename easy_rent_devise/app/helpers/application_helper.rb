module ApplicationHelper
    
  def matchesRentPath?(path)
    if path == home_my_info_path || path == home_pay_rent_path || path == home_payment_history_path
      true
    else
      false
    end
  end
    
  def matchesMaintenancePath?(path)
    if path == home_maintenance_request_path || path == home_maintenance_log_path
      true
    else
      false
    end
  end
    
  def matchesNotificationPath?(path)
    # no notification paths yet
    false
  end

  def matchesOtherPath?(path)
    # no other paths yet
    false
  end
    
end
