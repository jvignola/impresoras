class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin_user!, except: [:index, :show, :search]

  def agotado
    @product = Product.find(params[:product_id])
    @product.marcar_agotado
    respond_to do |format|
      format.html { redirect_to products_path, notice: 'El producto quedó marcado como agotado' }
    end
  end

  def en_stock
    @product = Product.find(params[:product_id])
    @product.marcar_en_stock
    respond_to do |format|
      format.html { redirect_to products_path, notice: 'El producto quedó marcado como en stock' }
    end
  end

  # GET /search
  def search 
    @products = Product.search(params[:search]).paginate(page: params[:page], per_page:10)
    @listado = true
    @order = Order.new
    render 'index'
  end

  # GET /products
  # GET /products.json
  def index
    @products = Product.all.paginate(page: params[:page], per_page:10)
    @listado = true
    @order = Order.new
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @order = Order.new
    @interaction = Interaction.new
    @listado = false
    @lista_interacciones = Interaction.where(product: @product)
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
      params.require(:product).permit(:name, :description, :price, :image)
    end
end
