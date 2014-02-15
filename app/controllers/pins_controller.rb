class PinsController < ApplicationController
  before_action :set_pin, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

 def index
   @pins = Pin.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 20)
 end

  def show
    @pin = Pin.find params[:id]
    @pin.liked_by current_user
    @prev = Pin.where("id < #{@pin.id}").order(:id => :desc).first
    @next = Pin.where("id > #{@pin.id}").order(:id => :asc).first
  end

  def new
    @pin = current_user.pins.build
  end

  def edit
  end

  def upvote
    @pin = Pin.find params[:id]
    @pin.liked_by @current_user
    redirect_to pin_path(@pin)
  end

  def downvote
    @pin = Pin.find params[:id]
    @pin.downvote_from @current_user
    redirect_to pin_path(@pin)
  end

  def create
    @pin = current_user.pins.build(pin_params)

    respond_to do |format|
      if @pin.save
        format.html { redirect_to @pin, notice: 'Pin was successfully created.' }
        format.json { render action: 'show', status: :created, location: @pin }
      else
        format.html { render action: 'new' }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @pin.update(pin_params)
        format.html { redirect_to @pin, notice: 'Pin was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @pin.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @pin.destroy
    respond_to do |format|
      format.html { redirect_to pins_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pin
      @pin = Pin.find(params[:id])
    end

    def correct_user
      @pin = current_user.pins.find_by(id: params[:id])
      redirect_to pins_path, notice: "Not authorized to edit this pin" if @pin.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pin_params
      params.require(:pin).permit(:description, :image)
    end
end
