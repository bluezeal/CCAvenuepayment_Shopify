module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Ccavenue
        class Helper < ActiveMerchant::Billing::Integrations::Helper
		
		    mapping :amount, 'Amount'
            mapping :order, 'Order_Id'
			mapping :checksum,'checksum'
			mapping :redirect_url,'Redirect_Url'				
			mapping :order,'Merchant_Param'
			
			mapping :customer, 
			:name  => 'billing_cust_name',
         	:email => 'billing_cust_email',
            :phone => 'billing_cust_tel',
			:name  => 'delivery_cust_name',
          	:phone => 'delivery_cust_tel'
											 
			mapping :billing_address,
            :city     => 'billing_cust_city',
            :address1 => 'billing_cust_address',
            :state    => 'billing_cust_state',
            :zip      => 'billing_zip_code',
            :country  => 'billing_cust_country',
            :note     => 'billing_cust_notes'
			
			 mapping :shipping_address,  
			  :address1 => 'delivery_cust_address',
			  :city     => 'delivery_cust_city',
			  :state    => 'delivery_cust_state',
			  :zip      => 'delivery_zip_code',
			  :country  => 'delivery_cust_country'
			  
			   def redirect(mapping = {})
                        add_field( 'Redirect_Url', mapping[:return_url])
                        add_field('Merchant_Id', ActiveMerchant::Billing::Integrations::Ccavenue.merchant_id)
                        add_field('Checksum', getchecksum(	
                            ActiveMerchant::Billing::Integrations::Ccavenue.merchant_id,
							self.fields[self.mappings[:amount]],
                            self.fields[self.mappings[:order]],                           
                            mapping[:return_url],
                            ActiveMerchant::Billing::Integrations::Ccavenue.working_key
                        ))
               end

                private

				def getchecksum(*args)
					require 'zlib'
					Zlib.adler32 args.join('|'), 1
				end	
						
          end
		end
      end
    end
  end
end