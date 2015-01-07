class AdminController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    myself = current_user
    redirect_to new_org_path, :notice => t('customized_notice.bind_org') unless myself.bind_org?

    @jobs = myself.orgs.first.jobs.order(updated_at: :desc).paginate(:page => params[:page]) if myself.bind_org?
  end

  def settings
    myself = current_user
    redirect_to new_org_path, :notice => t('customized_notice.bind_org') unless myself.bind_org?

    @org = myself.orgs.first if myself.bind_org?
  end
end
