class ContactsController < ApplicationController
    # Defines a new method (and pulls corresponding view) while instantiating a new object (Contact model) for each page view from different get requests.
    def new
        @contact = Contact.new
    end
    
    # Defines a new method to create (contacts#create POST request) with parameters. Checks contact model for code (in this case, validations) and tries to save to db once submit button is clicked.
    def create
       @contact = Contact.new(contact_params)
        if @contact.save
            redirect_to new_contact_path
            flash[:success]= "Message sent."
        else
            redirect_to new_contact_path 
            flash[:warning]= @contact.errors.full_messages.join(", ")
        end
    end
    
    private
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end