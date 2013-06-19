class UserInterestsController < ApplicationController
  def new
		@user = User.find(params[:uid])
		@interests = Interest.all.map(&:name).join(", ")
  end

  def save
		@user = User.find(params[:uid])
		interests = JSON.parse(params["user_interest"]) rescue []
		interests.each do |i_name|
			interest = Interest.find_or_create_by_name(i_name)
			UserInterest.find_or_create_by_user_id_and_interest_id(@user.id, interest.id)
		end
    respond_to do |format|
      if @user.save
				uintrests = @user.interests
				extra_uis = uintrests.map(&:name) - interests
				extra_uis.each do |ui_name| 
          _interest = Interest.select('id').where(:name => ui_name).first
          UserInterest.find_by_user_id_and_interest_id(@user.id, _interest.id).destroy if _interest.present?
        end
        format.html { redirect_to @user, notice: 'User interest was successfully saved.' }
        format.json { head :no_content }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
