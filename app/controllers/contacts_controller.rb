class ContactsController < ApplicationController
    def new
        @contact = Contact.new
    end
    
    def create
       @contact = Contact.new(contact_params)
        if @contact.save
            redirect_to new_contact_path
            flash[:success]= "Message sent."
        else
            redirect_to new_contact_path 
            flash[:warning]= "Error occured."
        end
    end
    
    private
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end