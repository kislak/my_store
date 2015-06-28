class SpamerService
  attr_accessor :errors

  def initialize(notification)
    @message = notification.message
    @sender = notification.from
    @list = parse_list(notification.list)
    @spamer = Spamer::Base.new(Rails.application.secrets.spamer_pub, Rails.application.secrets.spamer_priv)
    validate
  end

  def process
    return if errors.present?
    return unless Rails.env == 'production'

    begin
      @list.each do |phone|
        @spamer.send_sms(phone, @message, {sender: @sender})
      end
    rescue SocketError
      @errors = ["something go wrong: @list.each do ... failed"]
    end
  end

  private

  def validate
    @errors ||= []
    @errors  << 'Message should present' if @message.blank?
    @errors  << 'List should present' if @list.blank?
    @errors  << 'From should present' if @sender.blank?
    @errors  << 'From should be < 11' if @sender && @sender.size > 11
  end

  def parse_list(list)
    list.split("\n").map do |item|
      item_with_no_letters = /[^a-zA-Z]+/.match(item)[0]
      item_with_no_letters.gsub(/[^0-9]/, '') #Only numbers
    end
  end
end