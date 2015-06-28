class NotificationsController < ApplicationController
  def new
    @contact_groups = ContactGroup.all
    @notification = Notification.new
  end

  def create
    @notification = Notification.create(notification_params(params))
    service = SpamerService.new(@notification)
    service.process
    if service.errors.present?
      flash.now[:error] = "Errors:<br> #{service.errors.join('<br>')}".html_safe
      render :new
    else
      flash.now[:success] = 'Done!'
    end
  end

  def notification_params(params)
    params.require(:notification).permit(:from, :message, :list)
  end
end
