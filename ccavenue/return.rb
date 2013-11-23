   if (params[AuthDesc])

            if @AuthDesc    

               @ccaResponse = {CCAVENUE_WORKING_KEY} 

        end

        @p = Rack::Utils.parse_nested_query @ccaResponse

        if (!@p.nil? && @p["Merchant_Id"] && @p["Order_Id"] && @p["Amount"] && @p["AuthDesc"] && @p["Checksum"])

          @checksum = verifyChecksum(@p["Merchant_Id"], @p["Order_Id"], @p["Amount"], @p["AuthDesc"], CCAVENUE_WORKING_KEY, @p["Checksum"])

          @authDesc = @p["AuthDesc"].eql?("Y") ? true : false

        end

      end

      if @checksum && @authDesc 

        transaction = Transaction.find(@p["Order_Id"])

        transaction.payment_confirmed = true

        transaction.save!

        message = current_buyer.user.name + "! Thank you for shopping with us. Your credit card has been charged and your transaction is successful. We will be shipping your order to you soon.!" 

        redirect_to root_path, :flash => {:success => message}

      else

        if !@authDesc

          message = current_buyer.user.name + "! Thank you for shopping with us.We will keep you posted regarding the status of your order through e-mail." 

          redirect_to root_path, :flash => {:error => message}

        else

          message = current_buyer.user.name + "! Thank you for shopping with us.However,the transaction has been declined by CCAvenue." 

          redirect_to root_path, :flash => {:error => message}

        end

      end

    else

      message = current_buyer.user.name + "! Security Error. Illegal access detected. " 

      redirect_to root_path, :flash => {:success => message}

    end
  end
