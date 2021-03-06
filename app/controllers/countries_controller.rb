class CountriesController < InheritedResources::Base
  respond_to :html, :json
  load_and_authorize_resource

  def update
    @country = Country.find(params[:id])
    if params[:position]
      @country.insert_at(params[:position])
      redirect_to countries_url
      return
    end
    update!
  end

  def index
    @countries = @countries.page(params[:page])
  end
end
