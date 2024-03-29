class LinksController < ApplicationController
  before_action :set_link, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: [:redirect]

  # GET /links or /links.json
  def index
    @links = current_user.links.all
  end

  # GET /links/1 or /links/1.json
  def show; end

  # GET /links/new
  def new
    @link = Link.new
  end

  # GET /links/1/edit
  def edit; end

  # POST /links or /links.json
  def create
    @link = current_user.links.new(link_params)

    respond_to do |format|
      if @link.save
        Links::HeadJob.perform_async(@link.id)
        format.html { redirect_to link_url(@link), notice: 'Link was successfully created.' }
        format.json { render :show, status: :created, location: @link }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /links/1 or /links/1.json
  def update
    respond_to do |format|
      if @link.update(link_params)
        Links::HeadJob.perform_async(@link.id)
        format.html { redirect_to link_url(@link), notice: 'Link was successfully updated.' }
        format.json { render :show, status: :ok, location: @link }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /links/1 or /links/1.json
  def destroy
    @link.destroy!

    respond_to do |format|
      format.html { redirect_to links_url, notice: 'Link was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def redirect
    @link = Link.find_by_short_code(params[:short_code])
    render 'errors/404', status: 404 if @link.nil?
    @link.update_attribute(:clicks, @link.clicks.to_i + 1)
    redirect_to @link.url, allow_other_host: true, status: 301
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_link
    @link = current_user.links.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def link_params
    params.require(:link).permit(:user_id, :url, :title, :favicon, :short_code, :expiry_date, :clicks, :validated,
                                 :deleted)
  end
end
