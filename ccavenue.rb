ActiveMerchant::Billing::Integrations::Ccavenue.setup do |cca|
  cca.merchant_id = M_demo1_1828 #your CCAvenue merchant id from the working key generation page
  cca.work_key = ekvb7aezafo9r38ikfdfzrvy6srsl8st #your CCAvenue working key
end
CCAVENUE_ACCOUNT = 'demo1'
ActionView::Base.send :include, ActiveMerchant::Billing::Integrations::ActionViewHelper



module ActiveMerchant #:nodoc:
  module Billing #:nodoc:
    module Integrations #:nodoc:
      module Ccavenue
		
		autoload :Return, File.dirname(__FILE__) + '/ccavenue/return.rb'
        autoload :Helper, File.dirname(__FILE__) + '/ccavenue/helper.rb'
               
        mattr_accessor :production_url 
        self.production_url = 'https://www.ccavenue.com/shopzone/cc_details.jsp' 
        
		
		def self.service_url
          self.production_url
        end

        def self.notification(post, options)
          Notification.new(post, options)
        end

        def self.return(query_string, options = {})
          Return.new(query_string)
        end
		
	 end
    end
  end
end
