class NotificationsController < ApplicationController
  before_action :get_groups
  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.create(notification_params(params))
    if (@notification.valid?)
      render :new
      return
    end
    service = SpamerService.new(@notification)
    service.process
    if service.errors.present?
      flash.now[:error] = "Errors:<br> #{service.errors.join('<br>')}".html_safe
      render :new
    else
      flash.now[:success] = 'Done!'
    end
  end

  private

  def notification_params(params)
    params.require(:notification).permit(:from, :message, :list)
  end

  def get_groups
    @contact_groups = ContactGroup.all
  end
end
