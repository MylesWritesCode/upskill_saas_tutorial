class ProfilesController < ApplicationController
  
  # GET request to /users/:user_id/profile/new
  def new
    # Render new blank profile detail form.
    @profile = Profile.new
  end
  
  # POST request to /users/:user_id/profile
  def create
    # First grabs the user id from the parameters on the page based on login.
    @user = User.find( params[:user_id] )
    # We're using @user.build_profiles, so that the form is tied to the user that's logged in.
    @profile = @user.build_profile( profile_params )
    if @profile.save
      flash[:success] = "Profile updated!"
      redirect_to user_path( params[:user_id] )
    else
      render action: :new
    end
  end
  
  # GET request to /users/:user_id/profile/edit
  def edit
    @user = User.find( params[:user_id] )
    @profile = @user.profile
  end
  
  private
    def profile_params
      params.require(:profile).permit(
        :first_name, 
        :last_name,
        :avatar,
        :job_title, 
        :phone_number, 
        :contact_email, 
        :description
      )
    end
end