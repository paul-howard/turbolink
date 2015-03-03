class InvitationsController < ApplicationController
  before_action :current_user

  def new
    @invitation = Invitation.new
  end

  def create
    @invitation = Invitation.new

    # Validate phone_num here; bounce with error if invalid or existing acct

    @invitation.from_user = params[:invitation][:from_user]
    @invitation.to_phone = params[:invitation][:to_phone]
    @invitation.is_used = false
    @invitation.expiration = 15.days.from_now
    # @invitation.uuid = SecureRandom.uuid        # TODO -- Use uuid instead of user_id for url
    @invitation_url = 'http://turbolink.herokuapp.com/users/' + @invitation.from_user
    puts ">>> @invitation: " + @invitation.inspect

    sid   = ENV["twilio_account_sid"] 
    token = ENV["twilio_auth_token"]
    @client  = Twilio::REST::Client.new sid, token
    @message = @client.account.messages.create(
      :body => "Nice to meet you! Here's a link to my contact info: #{@invitation_url}",
      :to   => @invitation.to_phone,
      :from => "+14242874527"
      )
    puts @message.to                      # TODO -- Error-check response If fail, render with flash

    @invitation.save

    redirect_to invitation_path(@invitation)
  end

  def show
  end

  def edit
  end

# Never trust parameters from the scary internet, only allow the white list through.
    def invitation_params
      params.require(:invitation).permit(:id, :from_user, :to_phone)
    end


end
