class EmailContactsController < ApplicationController

  def create
    @email_contact = EmailContact.new(params[:email_contact])
    if @email_contact.save
      @email_contact = EmailContact.new
      render "pages/home", flash: { success: "Email stored" }
    else
      render "pages/home"#, flash: { error: "Duplicate email" }#@email_contact.errors.first
    end
  end
end