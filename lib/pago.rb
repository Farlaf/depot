require 'ostruct'

class Pago
  def self.make_payment(order_id:,
                        payment_method:,
                        payment_details:)
    case payment_method
    when :check
      Rails.logger.info("Processing check: #{payment_details.fetch(:routing)}/#{payment_details.fetch(:account)}")
    when :credit_card
      Rails.logger.info("Processing credit card: #{payment_details.feth(:cc_num)}/#{payment_details.feth(:expiration_month)}/#{payment_details.feth(:expiration_year)}")
    when :po
      Rails.logger.info("Processing purchase order:#{payment_details.fetch(:po_num)}")
    else
      raise "Unknown payment_method #{payment_method}"
    end

    sleep(10) unless Rails.env.test?

    Rails.logger.info('Done Processing Payment')
    OpenStruct.new(succeeded?: true)
  end
end
