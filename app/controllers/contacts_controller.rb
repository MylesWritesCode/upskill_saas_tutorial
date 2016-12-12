class ContactsController < ApplicationController
    # Defines a new method (and pulls corresponding view) while instantiating a new object (Contact model) for each page view from different get requests.
    def new
        @contact = Contact.new
    end
    
    # Defines a new method to create (contacts#create POST request) with parameters. Checks contact model for code (in this case, validations) and tries to save to db once submit button is clicked.
    def create
       @contact = Contact.new(contact_params)
        if @contact.save
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            ContactMailer.contact_email(name, email, body).deliver
            flash[:success]= "Message sent."
            redirect_to new_contact_path
        else
            # The following code is trying to get all the error messages to show.
            # @contact.errors.each do |msg|
                # flash[:warning] = ("#{msg.capitalize} can't be blank.")
            # end
            
            # All of the error messages show with the following code, but they aren't showing how I want them to.
            # flash[:warning]= @contact.errors.full_messages.join(", ")
            
            # This code will show whenever there are any errors, but won't be specific as to why there's an error.
            flash[:warning]= "Please fill out all of the form fields."
            redirect_to new_contact_path
        end
    end
    
    private
        # To collect data from form, we need to use strong parameters and whitelist form fields.
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end