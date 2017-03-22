class AccountEditsController < ApplicationController

  before_action :set_current_user

  def new
    @account_edit = AccountEdit.new
  end

  def create
    @account_edit = AccountEdit.new(account_edit_params)
    @account_edit.edit

    if @account_edit.valid?
      respond_to do |format|
        format.html {
          redirect_to new_account_edit_path,
          notice: "Account edit success!"
        }
      end
    else
      respond_to do |format|
        format.html {
          render :new
        }
      end
    end
  end

  private

  def account_edit_params
    params.require(:account_edit).permit([:name, :email]).merge({user: @user})
  end

  def set_current_user
    @user = current_user
  end
end
