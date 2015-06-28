class SpamerController < ApplicationController
  def new
    @contact_groups = ContactGroup.all
  end

  def create
    service = SpamerService.new(params)
    service.process
    if service.errors.present?
      flash.now[:error] = "Errors:<br> #{service.errors.join('<br>')}".html_safe
      render :new
    else
      flash.now[:success] = 'Done!'
    end
  end
end
