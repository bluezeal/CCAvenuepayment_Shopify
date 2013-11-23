module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module ccavenue
        class Helper < ActiveMerchant::Billing::Integrations::Helper
			
			
		    orderID = @transaction.id.to_s

			amount = @transaction.total_amount.to_s

			redirectURL =  root_path
			
			checksum = getChecksum(CCAVENUE_MERCHANT_ID, orderID, amount, redirectURL, CCAVENUE_WORKING_KEY)

			@ccaRequest = 

			  "Merchant_Id="+CCAVENUE_MERCHANT_ID+"&"+

			  "Amount="+amount+"&"+

			  "Order_Id="+orderID+"&"+

			  "Redirect_Url="+redirectURL+"&"+

			  "billing_cust_name="+current_user.name+"&"+

			  "billing_cust_address="+@transaction.address.street_address+"&"+

			  "billing_cust_country="+@transaction.address.country+"&"+

			  "billing_cust_tel="+@transaction.address.cell_phone+"&"+

			  "billing_cust_email="+current_user.email+"&"+

			  "billing_cust_state="+@transaction.address.state+"&"+

			  "delivery_cust_name="+current_user.name+"&"+

			  "delivery_cust_address="+@transaction.address.street_address+"&"+

			  "delivery_cust_country="+@transaction.address.country+"&"+

			  "delivery_cust_state="+@transaction.address.state+"&"+

			  "delivery_cust_tel="+@transaction.address.cell_phone+"&"+

			  "delivery_cust_notes="+"Note"+"&"+

			  "billing_cust_city="+@transaction.address.city+"&"+

			  "billing_zip_code="+@transaction.address.pincode.to_s+"&"+

			  "delivery_cust_city="+@transaction.address.city+"&"+

			  "delivery_zip_code="+@transaction.address.pincode.to_s+"&"+

			  "Checksum="+checksum.to_s
			  
				
				
				def verifyChecksum( merchantID,  orderID,  amount,  authDesc,  workingKey,  checksum) 

					String str = merchantID+"|"+orderID+"|"+amount+"|"+authDesc+"|"+workingKey

					String newChecksum = Zlib::adler32(str).to_s

					return (newChecksum.eql?(checksum)) ? true : false

				end

			   def getChecksum( merchantID,  orderID,  amount,  redirectUrl,  workingKey) 

					String str = merchantID + "|" + orderID + "|" + amount + "|" + redirectUrl + "|" + workingKey;

					return Zlib::adler32(str)

			   end
  
  
				
          end
		end
      end
    end
  end
end