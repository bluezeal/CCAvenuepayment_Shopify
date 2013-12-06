module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Ccavenue
        class Return < ActiveMerchant::Billing::Integrations::Return
			def valid?	
                        verifychecksum(
							  ActiveMerchant::Billing::Integrations::Ccavenue.merchant_id,
							 self.Order_Id,
							 self.Amount,
							 self.AuthDesc,
							 self.CheckSum,
							 ActiveMerchant::Billing::Integrations::Ccavenue.working_key
                        )
            end
			
			def complete?
				'Y' == self.AuthDesc
				true == valid
				message = message_from(AuthDesc)
			end
			def pending?
				'B' == self.AuthDesc
				true == valid
				message = message_from(AuthDesc)
				
			end
			def decline?
				'N' == self.AuthDesc
				true == valid
				message = message_from(AuthDesc)
			end
			def cancel?
				false == valid
				message = message_from(AuthDesc)
			end
			
			def Order_Id
				params['Order_Id']
			end	

			def Checksum
				params['Checksum']
			end

			# the money amount we received in X.2 decimal.
			def Amount
				params['Amount']
			end

			def AuthDesc
				params['AuthDesc']
			end
			private

			def verify_checksum(checksum, *args)
				require 'zlib'
				Zlib.adler32(args.join('|'), 1).to_s.eql?(checksum)
			end
				
		  def message_from(AuthDesc)
			 when "Y"
				 message = 'Thank you for shopping with us. Your credit card has been charged and your transaction is successful. We will be shipping your order to you soon.';
			 when "B"
				 message = 'Thank you for shopping with us.We will keep you posted regarding the status of your order through e-mail.';
			 when "N"
				message = 'Thank you for shopping with us.However,the transaction has been declined by CCAvenue.';
			 else
				message = 'Security Error. Illegal access detected';
		  end			 
		end
      end
    end
  end
end