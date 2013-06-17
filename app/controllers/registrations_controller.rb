class RegistrationsController < Devise::RegistrationsController
  before_filter :parse_params, :only => [ :create ]
  
  def create
    super
  end
  
  private
  def parse_params
    params["user"]["location_country"] = JSON.parse(params["user"]["location_country"]).first rescue nil
  end
end
