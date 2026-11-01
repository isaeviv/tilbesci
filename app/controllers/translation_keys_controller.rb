class TranslationKeysController < ApplicationController
  before_action :set_translation_key, only: %i[ show edit update destroy ]

  # GET /translation_keys or /translation_keys.json
  def index
    @pagy, @translation_keys = pagy(:offset, TranslationKey.all.includes(:game, :batch), limit: 20)
  end

  # GET /translation_keys/1 or /translation_keys/1.json
  def show
  end

  # GET /translation_keys/new
  def new
    @translation_key = TranslationKey.new
  end

  # GET /translation_keys/1/edit
  def edit
  end

  # POST /translation_keys or /translation_keys.json
  def create
    @translation_key = TranslationKey.new(translation_key_params)

    respond_to do |format|
      if @translation_key.save
        format.html { redirect_to @translation_key, notice: t(".notice") }
        format.json { render :show, status: :created, location: @translation_key }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @translation_key.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /translation_keys/1 or /translation_keys/1.json
  def update
    respond_to do |format|
      if @translation_key.update(translation_key_params)
        format.html { redirect_to @translation_key, notice: t(".notice"), status: :see_other }
        format.json { render :show, status: :ok, location: @translation_key }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @translation_key.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /translation_keys/1 or /translation_keys/1.json
  def destroy
    @translation_key.destroy!

    respond_to do |format|
      format.html { redirect_to translation_keys_path, notice: t(".notice"), status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_translation_key
      @translation_key = TranslationKey.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def translation_key_params
      params.expect(translation_key: [ :name, :description, :state, :game_id, :translated ])
    end
end
