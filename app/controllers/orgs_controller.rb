require_relative '../../lib/exceptions'

class OrgsController < ApplicationController
  before_action :set_org, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource
  
  # GET /orgs
  # GET /orgs.json
  def index
    @orgs = Org.all.paginate(:page => params[:page])
  end

  # GET /orgs/1
  # GET /orgs/1.json
  def show
    if params[:only_closed]
      @jobs = @org.jobs.closed.order(updated_at: :desc).paginate(:page => params[:page])
    elsif params[:all]
      @jobs = @org.jobs.order(updated_at: :desc).paginate(:page => params[:page])
    else
      @jobs = @org.jobs.open.order(updated_at: :desc).paginate(:page => params[:page])
    end
  end

  # GET /orgs/new
  def new
    raise ::Exceptions::AlreadyBindOrgError if current_user.bind_org?
    @org = Org.new
  end

  # GET /orgs/1/edit
  def edit
    session[:return_to] ||= request.referer
  end

  # POST /orgs
  # POST /orgs.json
  def create
    raise ::Exceptions::AlreadyBindOrgError if current_user.bind_org?
    @org = Org.new(org_params)
    @org.user_id = current_user.id

    respond_to do |format|
      if @org.save
        format.html { redirect_to settings_path, flash: { success: 'Org was successfully bound.'} }
        format.json { render :show, status: :created, location: @org }
      else
        format.html { render :new }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orgs/1
  # PATCH/PUT /orgs/1.json
  def update
    respond_to do |format|
      if @org.update(org_params)
        format.html { redirect_to :back, flash: { success: 'Org was successfully updated.'} }
        format.json { render :show, status: :ok, location: @org }
      else
        format.html { render :edit }
        format.json { render json: @org.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orgs/1
  # DELETE /orgs/1.json
  def destroy
    @org.destroy
    respond_to do |format|
      format.html { redirect_to orgs_url, success: 'Org was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org
      @org = Org.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def org_params
      params.require(:org).permit(:name, :link, :desc)
    end
end
