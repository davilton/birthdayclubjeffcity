class BirthdayDealsController < ApplicationController
  
  before_filter :authenticate_user!, only: [:birthday, :not_birthday]
  before_filter :verify_login_and_birthday

  respond_to :html, :json

  def index
    # if user_signed_in?
    #   render action: 'index_view_birthday_deals'
    # end  
  end

  def account
    @user = current_user
  end

protected

  def verify_login_and_birthday
    if user_signed_in?
      birthday = current_user.adjusted_birthday
      return render 'customer_enter_birthday' if birthday.nil?
      unless current_user.eligible_for_birthday_deals?
        return render 'index_not_your_birthday'
      end

    else
      session[:return_to] = birthday_deals_path
      return render 'index_customer_login'
    end
  end
end