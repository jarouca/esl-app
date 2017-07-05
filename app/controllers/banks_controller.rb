class BanksController < ApplicationController

  def index
    @banks = Bank.where(user_id: params["user_id"])
  end

  def show
    @bank = Bank.find(params["id"])
    @word = Word.new
    @words = Word.where(bank_id: @bank.id)
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

  def destroy
    bank = Bank.find(params["id"])

    if bank.user_id == current_user.id
      bank.destroy
      flash[:notice] = "Bank deleted successfully"
      redirect_to user_banks_path
    end
  end

  private

  def bank_params
    params.require(:bank).permit(
    :title
    )
  end

end
