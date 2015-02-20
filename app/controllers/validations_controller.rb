class ValidationsController < ApplicationController

  def new
  end

  def create
    @sanity = "check check"
    @validation = Validation.new(validation_params)
    # TODO: Come up with a better code generator. ;-)
    @validation.code = 'WDIROCKS'
    # Generate & send sms message via Twilio api
    # Create record in db
    # Forward to next view
  end

  def edit
    # Check for expiration
    # Set is_used = true
    # Forward to next view
  end

  # Never trust parameters from the scary internet, only allow the white list through.
    def validation_params
      params.permit(:phone_num, :code)
    end

end
