class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

 PAGE_SIZE = 5
  # GET /products
  # GET /products.json
 

  def index
    @page = (params[:page] || 0).to_i

    if params[:keywords].present?
      @keywords = params[:keywords]
      @products = Product.where("lower(name) LIKE '%#{@keywords.downcase}%'").order(:name)
                    .offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
      number_of_records = Product.where("lower(name) LIKE '%#{@keywords.downcase}%'").count
    else
      @products = Product.order(:name).offset(PAGE_SIZE * @page).limit(PAGE_SIZE)
      number_of_records = Product.count
    end
      @number_of_pages = (number_of_records % PAGE_SIZE) == 0 ? 
                       number_of_records / PAGE_SIZE - 1 : number_of_records / PAGE_SIZE
  end   

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :description, :cost_price, :sale_price)
    end
end
