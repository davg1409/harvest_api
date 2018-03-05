class Api::V1::VendorsController < ApplicationController
  before_action :authenticate_api_v1_user!
  before_action :set_vendor, except: [:index, :create]

  # GET /vendors
  # GET /vendors.json
  def index
    @vendors = Vendor.all
  end

  # GET /vendors/1
  # GET /vendors/1.json
  def show
  end

  # POST /vendors
  # POST /vendors.json
  def create
    @vendor = Vendor.new vendor_params

    if @vendor.save
      render :show
    else
      render json: { errors: @vendor.errors.full_messages }, status: 422
    end
  end

  # PATCH/PUT /vendors/1
  # PATCH/PUT /vendors/1.json
  def update
    if @vendor.update vendor_params
      render :show
    else
      render json: { errors: @tag.errors.full_messages }, status: 422
    end
  end

  # DELETE /vendors/1
  # DELETE /vendors/1.json
  def destroy
    if @vendor.destroy
      render :show
    else
      render json: { errors: "Not able to destroy Vendor!!!" }, status: 422
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor
      @vendor = Vendor.find params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def vendor_params
      params.require(:vendor).permit!
    end
    
    def permit!
      each_pair do |key, value|
        convert_hashes_to_parameters(key, value)
        self[key].permit! if self[key].respond_to? :permit!
      end
    
      @permitted = true
      self
    end
end
