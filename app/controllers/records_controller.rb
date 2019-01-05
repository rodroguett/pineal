class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /records
  # GET /records.json
  def index
    @filter = params[:filter]
    @records = if @filter
      Record.where('status IN (?)', @filter)
    else
      Record.all
    end

    # todos los existentes para mostrarlos para los filtros
    @statuses = Record.pluck(:status).uniq
    @roles = Record.select(:rol).distinct
    @vps = Record.select(:vp).distinct

    @filter_roles =
      if params[:roles_filter].blank? # en este caso van todos los roles
        @roles.pluck(:rol)
      else
        params[:roles_filter]
      end
    @filter_vps =
      if params[:vps_filter].blank? # en este caso van todos los vps
        @vps.pluck(:vp)
      else
        params[:vps_filter]
      end
    @table_records = Record.where("rol in (?) AND vp in (?)", @filter_roles, @filter_vps)
  end

  def download
    @filter = params[:filter]
    @records = if @filter
      Record.where('status IN (?)', @filter)
    else
      Record.all
    end
    render "records/download.xlsx.axlsx"
  end

  # GET /records/1
  # GET /records/1.json
  def show
  end

  # GET /records/new
  def new
    @record = Record.new
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  # POST /records.json
  def create
    @record = Record.new(record_params)

    respond_to do |format|
      if @record.save
        format.html { redirect_to @record, notice: 'Se creó el concurso' }
        format.json { render :show, status: :created, location: @record }
      else
        format.html { render :new }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record, notice: 'Se actualizó el concurso.' }
        format.json { render :show, status: :ok, location: @record }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record.destroy
    respond_to do |format|
      format.html { redirect_to records_url, notice: 'Se eliminó el concurso' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:vp, :gerencia, :si, :cargo, :rol, :nvacantes, :apto, :noapto, :encoordinacion, :npostulantes, :diasconcurso, :fechaapertura, :fechaaprobacionceo, :fechaingreso, :status, :comentario, :filter)
    end
end
