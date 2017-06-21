class BanksController < ApplicationController

  def new
    @bank = Bank.new
    @user = current_user
  end

  def create
    @bank = Bank.new(bank_params)
    @bank.user_id = params["user_id"]

    if @bank.save
      flash[:notice] = "Bank successfully created."
      redirect_to root_path
    else
      @user = current_user
      render :new
    end
  end

  private

  def bank_params
    params.require(:bank).permit(
    :title
    )
  end

end
