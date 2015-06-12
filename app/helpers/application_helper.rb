module ApplicationHelper
  FLASH_BOOTSTRAP_CLASSES = {
    success: 'alert-success',
    error: 'alert-error',
    alert: 'alert-block',
    notice: 'alert-info'
  }

  def bootstrap_class_for(flash_type)
    FLASH_BOOTSTRAP_CLASSES[flash_type.to_sym] || flash_type.to_s
  end
end
