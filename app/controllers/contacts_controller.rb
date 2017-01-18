class ContactsController < ApplicationController
  
  # GET request to /contactu-us
  # Show new contact form
  def new
   @contact = Contact.new
  end
  
  # POST request /contacts
  def create
    # Mass assigment of form fields into Contact object
    @contact = Contact.new(contact_params)
    # Save the Contact object to the database
    if @contact.save
      # Store form fileds via parameters, into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # Plug vairables into Contact Mailer
      # email method and send email
      ContactMailer.contact_email(name, email, body).deliver
      # If Contact object doesn't save,
      # store errors in flash has,
      # and redirect to the new action
      flash[:success] = "Message sent."
      redirect_to new_contact_path #, notice: "Message sent."
    else
      flash[:danger] = @contact.errors.full_messages.join(", ")
      redirect_to new_contact_path #, notice: "Error occured."
    end
  end
  
  private
  # To collect data from form, we need to use
  # strong parameters and whitelist the form fields
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end