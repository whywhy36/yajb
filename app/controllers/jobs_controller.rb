require_relative '../../lib/exceptions'

class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :create, :update, :destroy]
  load_and_authorize_resource

  # GET /jobs
  # GET /jobs.json
  def index
    user = current_user || User.new
    @jobs = user.admin? ? Job.all.order(updated_at: :desc).paginate(:page => params[:page]) : Job.open.order(updated_at: :desc).paginate(:page => params[:page])
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    raise ::Exceptions::NeedBindOrgError unless current_user.bind_org?

    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
    session[:return_to] ||= request.referer
  end

  # POST /jobs
  # POST /jobs.json
  def create
    raise ::Exceptions::NeedBindOrgError unless current_user.bind_org?

    @job = Job.new(job_params)
    @job.org_id = current_user.orgs.first.id

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, success: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to session.delete(:return_to), success: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to :back, success: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params.require(:job).permit(:title, :jd, :type_id, :category_id, :status)
    end
end
