class SpamerService
  attr_accessor :errors

  def initialize(params)
    @message = params[:message]
    @sender = params[:from]
    @list = params[:list].try(:split)
    @spamer = Spamer::Base.new(Rails.application.secrets.spamer_pub, Rails.application.secrets.spamer_priv)
    validate
  end

  def process
    return if errors.present?
    @list.each do |phone|
      @spamer.send_sms(phone, @message, {sender: @sender})
    end
  end

  def validate
    @errors ||= []
    @errors  << 'Message should present' if @message.blank?
    @errors  << 'List should present' if @list.blank?
    @errors  << 'From should present' if @sender.blank?
    @errors  << 'From should be < 11' if @sender && @sender.size > 11

  end
end