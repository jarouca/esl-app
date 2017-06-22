class BanksController < ApplicationController

  def index
    @banks = Bank.where(user_id: params["user_id"])
  end

  def show
    @bank = Bank.find(params["id"])
  end

  def edit
    @bank = Bank.find(params["id"])
    @user = current_user
  end

  def update
    @bank = Bank.find(params["id"])
    @bank.update(bank_params)

    if @bank.save
      flash[:notice] = 'Bank successfully updated.'
      redirect_to user_bank_path
    else
      @user = current_user
      render 'edit'
    end
  end

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
