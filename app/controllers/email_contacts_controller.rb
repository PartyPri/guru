class EmailContactsController < ApplicationController

  def create
    @email_contact = EmailContact.new(params[:email_contact])
    if @email_contact.save
      @email_contact = EmailContact.new
<<<<<<< HEAD
      flash[:success] = "Thanks for joining our launch list!"
      redirect_to root_url
      
    else
      flash[:error] = @email_contact.errors.full_messages.first
      redirect_to root_url
=======
      render "pages/landing", flash: { success: "Email stored" }
    else
      render "pages/landing", flash: { error: "Duplicate email" }#@email_contact.errors.first
>>>>>>> develop
    end
  end
end