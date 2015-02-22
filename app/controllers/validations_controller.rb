require 'twilio-ruby'

class ValidationsController < ApplicationController
#
  def new
  end
#
  def create
    @validation = Validation.new(validation_params)

    # Validate phone_num here; bounce with error if invalid or existing acct

    @validation.code = 'WDIROCKS'         # TODO: Replace testing code here
    @validation.phone_num = 3105074234    #       this line can go after testing, too
    @validation.is_used = false
    @validation.expiration = 15.minutes.from_now
    @validation.uuid = SecureRandom.uuid

    sid   = ENV["twilio_account_sid"] 
    token = ENV["twilio_auth_token"]
    @client  = Twilio::REST::Client.new sid, token
    @message = @client.account.messages.create(
      :body => "Your requested Verification Code from Turbolink: #{@validation.code}",
      :to   => @validation.phone_num,
      :from => "+14242874527"
      )
    puts @message.to

    Validation.create(
      phone_num: @validation.phone_num, 
      code: @validation.code, 
      is_used: @validation.is_used, 
      expiration: @validation.expiration,
      uuid: @validation.uuid
      )

    @validation = Validation.find_by_uuid(@validation.uuid)
    redirect_to @validation

  end
#####
  def show
    @validation = Validation.find_by_id(validation_params[:id])
    # logger.info("validation: " + @validation.inspect)    
  end
#####
  def update
    @validation = Validation.find_by_id(validation_params[:id])
    if @validation
      if @validation.expiration < Time.now          # validation has expired
        flash.now[:danger] = "Sorry, this code has expired."  # TODO: Change this to a modal window with option to send new text.
        render 'show'
      else
        @validation.update(is_used: true)
        session[:validation_id] = @validation.id
        redirect_to new_user_path
      end
    else
      flash.now[:danger] = "That's weird. I can't seem to find what I'm looking for..."
      render 'show'
    end
  end
#####
  # Never trust parameters from the scary internet, only allow the white list through.
    def validation_params
      params.permit(:id, :phone_num, :code)
    end

end
