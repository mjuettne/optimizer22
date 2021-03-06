class ApplicationController < ActionController::Base
  
  # before_action(:force_user_sign_in)
  before_action(:load_current_user)
  # Uncomment this if you want to force users to sign in before any other actions
  # before_action(:force_user_sign_in)
  def index
    render({:template => "home/home.html.erb"})
  end
  def load_current_user
    the_id = session[:user_id]
    @current_user = User.where({ :id => the_id }).first
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end

 def number_to_currency_br(number)
  number_to_currency(number, :unit => "R$ ", :separator => ",", :delimiter => ".")
end

def number_to_currency(number, options = {})
  delegate_number_helper_method(:number_to_currency, number, options)
end

end
