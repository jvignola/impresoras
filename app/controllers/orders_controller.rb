class OrdersController < ApplicationController

  require 'will_paginate/array'
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin_user!, only: [:show, :index, :entregar_orden, :ordenes_sin_autorizar_todas, :ordenes_autorizadas_sin_entregar, :ordenes_entregadas]
  before_action :authenticate_authorized_user!, only: [:autorizar_orden, :ordenes_a_autorizar_x_mi]
  before_action :authenticate_any_user!, only: [:ordenes_sin_autorizar, :ordenes_mias_autorizadas_sin_entregar, :ordenes_mias_entregadas, :new, :create, :edit, :update, :destroy]
  

  def entregar_orden
    @order = Order.find(params[:order_id])
    @order.entregar
    OrdersMailer.pedido_entregado(@order).deliver_later
    respond_to do |format|
      format.html { redirect_to ordenes_sin_entregar_path, notice: 'El pedido fue entregado' }
    end
  end 

  def autorizar_orden
    @order = Order.find(params[:order_id])
    @order.autorizar
    OrdersMailer.nuevo_pedido_autorizado(@order).deliver_later
    respond_to do |format|
      format.html { redirect_to mis_ordenes_para_autorizar_path, notice: 'El pedido fue autorizado' }
    end
  end 

  def ordenes_a_autorizar_x_mi
    @ordenes_sin_autorizar = Order.sin_autorizar
    @orders = []
    @ordenes_sin_autorizar.each do |orden_sin_autorizar|
      if orden_sin_autorizar.user.user == current_user
        @orders.push(orden_sin_autorizar)
      end
    end
    @estado = "para autorizar por mi"
    @orders = @orders.paginate(page: params[:page], per_page:10)
    render 'index'
  end

  def ordenes_sin_autorizar
    @orders = Order.mias(current_user.id).sin_autorizar.paginate(page: params[:page], per_page:10)
    @estado = "sin Autorizar"
    render 'index'
  end

  def ordenes_sin_autorizar_todas
    @orders = Order.sin_autorizar.paginate(page: params[:page], per_page:10)
    @estado = "sin Autorizar"
    render 'index'
  end

  def ordenes_mias_autorizadas_sin_entregar
    @orders = Order.mias(current_user.id).sin_entregar.paginate(page: params[:page], per_page:10)
    @estado = "Autorizados"
    render 'index'
  end

  def ordenes_mias_entregadas
    @orders = Order.mias(current_user.id).entregadas.paginate(page: params[:page], per_page:10)
    @estado = "Entregados"
    render 'index'
  end

  def ordenes_autorizadas_sin_entregar
    @orders = Order.sin_entregar.paginate(page: params[:page], per_page:10)
    @estado = "Autorizados"
    render 'index'
  end

  def ordenes_entregadas
    @orders = Order.entregadas.paginate(page: params[:page], per_page:10)
    @estado = "Entregados"
    render 'index'
  end

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all.paginate(page: params[:page], per_page:10)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @product = Product.find(params[:product_id])
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @order.user = current_user
    #@product = Product.find(params[:product_id])
    #@order.product = @product
    @order.autorizado = current_user.is_authorized_user?
    @order.entregado = false

    respond_to do |format|
      if @order.save
        if @order.autorizado
          OrdersMailer.nuevo_pedido_autorizado(@order).deliver_later
          @order.update(fecha_autorizado: DateTime.now)
        else
          OrdersMailer.pedido_para_autorizar(@order).deliver_later
        end 
        format.html { redirect_to products_path, notice: 'El pedido fue realizado' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    if @order.user == current_user || current_user.is_admin_user?
      respond_to do |format|
        if @order.update(order_params)
          format.html { redirect_to @order, notice: 'Order was successfully updated.' }
          format.json { render :show, status: :ok, location: @order }
        else
          format.html { render :edit }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
          format.html { redirect_to products_path, notice: 'No tienes los suficientes privilegios para editar el pedido' }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    if @order.user == current_user || current_user.is_admin_user?
      @order.destroy
      respond_to do |format|
        format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to orders_url, notice: 'No tienes los suficientes privilegios para eliminar el pedido' }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:cantidad, :product_id, :aclaracion)
    end
end
