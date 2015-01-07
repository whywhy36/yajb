require_relative '../../lib/exceptions'

class ApplicationController < ActionController::Base
  before_filter :set_types_and_categories

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to normal_redirect_url, :alert => exception.message
  end

  rescue_from ::Exceptions::NeedBindOrgError do |exception|
    redirect_to normal_redirect_url, :alert => t('customized_notice.alert_bind')
  end

  rescue_from ::Exceptions::AlreadyBindOrgError do |exception|
    redirect_to normal_redirect_url, :alert => t('customized_notice.alert_already_bind')
  end

  def set_types_and_categories
    @types = Type.all
    @categories = Category.all
  end

  def normal_redirect_url
    request.referer ? :back : root_url
  end
end
