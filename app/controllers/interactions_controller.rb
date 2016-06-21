class InteractionsController < ApplicationController
  before_action :set_interaction, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_admin_user!, only: [:respondidas, :sin_responder, :index, :show, :edit, :update, :destroy]
  before_action :authenticate_authorized_user!, only: []
  before_action :authenticate_any_user!, only: [:new, :create, :mis_respondidas, :mis_sin_responder]

  def respondidas
    @interactions = Interaction.respondidas.paginate(page: params[:page], per_page:2)
    @estado = "Respondidas"
    render 'index'
  end

  def sin_responder
    @interactions = Interaction.sin_responder.paginate(page: params[:page], per_page:2)
    @interaction = Interaction.new
    @estado = "sin Responder"
    render 'index'
  end

  def mis_respondidas
    @interactions = Interaction.mias(current_user.id).respondidas.paginate(page: params[:page], per_page:2)
    @estado = "Respondidas"
    render 'index'
  end

  def mis_sin_responder
    @interactions = Interaction.mias(current_user.id).sin_responder.paginate(page: params[:page], per_page:2)
    @interaction = Interaction.new
    @estado = "sin Responder"
    render 'index'
  end

  # GET /interactions
  # GET /interactions.json
  def index
    @interactions = Interaction.all
  end

  # GET /interactions/1
  # GET /interactions/1.json
  def show
  end

  # GET /interactions/new
  def new
    @interaction = Interaction.new
  end

  # GET /interactions/1/edit
  def edit
  end

  # POST /interactions
  # POST /interactions.json
  def create
    @interaction = Interaction.new(interaction_params)
    @interaction. user = current_user

    # TODO: luego de crear las preguntas o respuestas enviar mails a los involucrados

    respond_to do |format|
      if @interaction.save
        if @interaction.pregunta
          format.html { redirect_to @interaction.product, notice: 'Tu pregunta fue enviada.' }
        else
          @pregunta = Interaction.find(params[:interaction][:pregunta_id])
          @pregunta.interaction = @interaction
          @pregunta.respondida = true
          @pregunta.save
          format.html { redirect_to preguntas_sin_responder_path, notice: 'Tu respuesta fue enviada.' }
        end
        format.json { render :show, status: :created, location: @interaction }
      else
        format.html { render :new }
        format.json { render json: @interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interactions/1
  # PATCH/PUT /interactions/1.json
  def update
    respond_to do |format|
      if @interaction.update(interaction_params)
        format.html { redirect_to @interaction, notice: 'Interaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @interaction }
      else
        format.html { render :edit }
        format.json { render json: @interaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interactions/1
  # DELETE /interactions/1.json
  def destroy
    @interaction.destroy
    respond_to do |format|
      format.html { redirect_to interactions_url, notice: 'Interaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interaction
      @interaction = Interaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interaction_params
      params.require(:interaction).permit(:user_id, :product_id, :pregunta, :mensaje, :respondida)
    end
end
