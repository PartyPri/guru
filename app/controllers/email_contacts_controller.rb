class EmailContactsController < ApplicationController

  def create
    @email_contact = EmailContact.new(params[:email_contact])
    if @email_contact.save
      @email_contact = EmailContact.new
      flash[:success] = "Thanks for joining our launch list!"
    else
      flash[:error] = @email_contact.errors.full_messages.first
    end
      redirect_to root_url
  end
end
