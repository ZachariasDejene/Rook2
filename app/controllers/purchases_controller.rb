class PurchasesController < ApplicationController
  before_action :check_login
  # before_action :set_purchase, only: [:show] 
  load_and_authorize_resource

  def index
    @purchases = Purchase.chronological.to_a
  end

  def new
    puts "trying to print a new purchase"
    @purchase = Purchase.new
  end

  def show
  end

  def create
    puts "trying to create a purchase"
    @purchase = Purchase.new(purchase_params)
    @purchase.date = Date.current
    
    # respond_to do |format|
    #   puts "purchases controller create -- before if"
    #   if @purchase.save
    #       puts "purchases controller create -- in if"
    #       @item = @purchase.item_id
    #       format.js
    #       format.json { render action: 'show', status: :created, location: @item }
    #       format.html{redirect_to @item, notice: "Successfully added a purchase for #{@purchase.quantity} #{@purchase.item.name}."}
    #   else
    #       puts "purchases controller create -- in else"
    #       format.html{render action: 'new'}
    #       format.json{ render json: @purchase.errors, status: :unprocessable_entity }
    #       format.js
    #   end
    # end
    if @purchase.save
      respond_to do |format|
        puts "purchase saved"
        format.html{redirect_to purchases_path , notice: "Successfully added a purchase for #{@purchase.quantity} #{@purchase.item.name}."}
        @item = @purchase.item
        format.js        
      end
    else
      render action: 'new'
    end
  end

  private
  # def set_purchase
  #   @purchase = Purchase.find(params[:id])
  # end

  def purchase_params
    params.require(:purchase).permit(:item_id, :quantity)
  end
  
end