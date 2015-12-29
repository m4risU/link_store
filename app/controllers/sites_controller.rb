class SitesController < ApplicationController
  before_action :set_site, only: [:edit, :update]

  def index
    @site = Site.new(site_filter)
    @sites = Site.search(search_params).page(params[:page]).per(25)
  end

  def edit
  end

  def update
    respond_to do |format|
      if @site.update(site_params)
        format.js { render }
      else
        format.js { render :edit }
      end
    end
  end

  private

  def site_filter
    if params[:site].present?
      params.require(:site).permit(:search)
    else
      {}
    end
  end

  def search_params
    params[:site].present? ? params[:site][:search] : nil
  end

  def set_site
    @site = Site.find(params[:id])
  end

  def site_params
    params.require(:site).permit(:description, :source)
  end
end
