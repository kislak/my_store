class Notification < ActiveRecord::Base
=begin
  @errors  << 'Message should present' if @message.blank?
  @errors  << 'List should present' if @list.blank?
  @errors  << 'From should present' if @sender.blank?
  @errors  << 'From should be < 11' if @sender && @sender.size > 11
=end

  validates_presence_of :from, :message, :list
  validates_length_of :from, maximum: 11
end
