module ApplicationHelper
    def flash_class(level)
      bootstrap_alert_class = {
        "success" => "toast align-items-center text-bg-success",
        "error" => "toast align-items-center text-bg-danger",
        "notice" => "toast align-items-center text-bg-info",
        "alert" => "toast align-items-center text-bg-danger",
        "warn" => "toast align-items-center text-bg-warning"
      }
      bootstrap_alert_class[level]
    end
end
