class SitesController < ApplicationController
  before_action :set_site, only: [:edit, :update]

  def index
    @sites = Site.page(params[:page]).per(25)
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

  def set_site
    @site = Site.find(params[:id])
  end

  def site_params
    params.require(:site).permit(:description, :source)
  end
end
