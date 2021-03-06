class ItemsController < ApplicationController
  primary_key='code'
  # GET /items
  # GET /items.json
  def index
    @items = Item.found

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  #get /byID/?upc=123213
  # def byUPC
  #   upc = params[:upc]
  #   # item = Item.where('code = ?','upc').first
  #   
  #   item = Item.find_or_create_by_code(upc)
  #   redirect_to items_path
  # end
  
  # GET /items/1/upc
  def upc
    upc_code = params[:upc]
    redirect_to root_url, alert: 'Not a valid UPC' and return unless upc_code
    @item = Item.code_find_or_create_by(upc_code)
    redirect_to root_url, alert: 'No product matches found' and return unless @item.errors.empty?
    redirect_to add_item_to_cart_path(@item.id) and return
  end
  
  # GET /items/1
  # GET /items/1.json
  def show
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/new
  # GET /items/new.json
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.json
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to items_url }
      format.json { head :no_content }
    end
  end
end
