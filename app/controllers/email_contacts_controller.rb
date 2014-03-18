class EmailContactsController < ApplicationController

  def new
    @email_contact = EmailContact.new
  end

  def create
    @email_contact = EmailContact.new(params[:email_contact])
    if @email_contact.save
      @email_contact = EmailContact.new
      render "pages/landing", flash: { success: "Email stored" }
    else
      render "pages/landing", flash: { error: "Duplicate email" }#@email_contact.errors.first
    end
  end
end