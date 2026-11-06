class BatchesController < ApplicationController
  before_action :set_batch, only: %i[ translate parse show edit update destroy ]

  def translate
    if @batch.state.in_progress? || @batch.state.translated?
      redirect_to @batch, alert: t(".alert")
      return
    end

    target_locale = params[:target_locale]
    source_locale = params[:source_locale]
    
    job = Translating::HandleBatchByYandexJob.perform_later(@batch.id, source_locale, target_locale)
    redirect_to @batch, notice: t(".notice", job_id: job.job_id)
  end

  def parse
    if @batch.source_files.empty? || @batch.source_files.any? { |sf| sf.file.blank? }
      redirect_to @batch, alert: t(".alert")
    else
      job = Parsing::HandleBatchJob.perform_later(@batch.id)
      redirect_to @batch, notice: t(".notice", job_id: job.job_id)
    end
  end

  # GET /batches or /batches.json
  def index
    @pagy, @batches = pagy(:offset, Batch.all, limit: 20)
  end

  # GET /batches/1 or /batches/1.json
  def show
  end

  # GET /batches/new
  def new
    @batch = Batch.new
    @batch.source_files.build
  end

  # GET /batches/1/edit
  def edit
    @batch.source_files.build if @batch.source_files.empty?
  end

  # POST /batches or /batches.json
  def create
    @batch = Batch.new(batch_params)

    respond_to do |format|
      if @batch.save
        format.html { redirect_to @batch, notice: t(".notice") }
        format.json { render :show, status: :created, location: @batch }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @batch.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /batches/1 or /batches/1.json
  def update
    respond_to do |format|
      if @batch.update(batch_params)
        format.html { redirect_to @batch, notice: t(".notice"), status: :see_other }
        format.json { render :show, status: :ok, location: @batch }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @batch.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /batches/1 or /batches/1.json
  def destroy
    @batch.destroy!

    respond_to do |format|
      format.html { redirect_to batches_path, notice: t(".notice"), status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_batch
      @batch = Batch.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def batch_params
      params.require(:batch).permit(:game_id, :state, :source_locale, source_files_attributes: [ :id, :file, :_destroy ])
    end
end
