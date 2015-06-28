class NotificationsController < ApplicationController
  before_action :get_groups
  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.create(notification_params(params))

    if (@notification.valid?)
      service = SpamerService.new(@notification)
      service.process
      if service.errors.present?
        flash.now[:error] = "Errors:<br> #{service.errors.join('<br>')}".html_safe
      else
        flash.now[:success] = 'Done!'
      end
    end

    render :new
  end

  private

  def notification_params(params)
    params.require(:notification).permit(:from, :message, :list)
  end

  def get_groups
    @contact_groups = ContactGroup.all
  end
end
