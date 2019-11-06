class FishController < ApplicationController
  before_action :translate_params, only: [:create, :update]
  before_action :set_fish, only: [:show]
  before_action :set_user_fish, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, only: [:show, :new, :create, :edit, :update, :destroy]

  # GET /fish
  # GET /fish.json
  def index
    @fish = Fish.all
  end

  # GET /fish/1
  # GET /fish/1.json
  def show
    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: @fish.name,
        description:@fish.description,
        amount: @fish.price,
        currency: 'aud',
        quantity: 1,
      }],
      payment_intent_data: {
        metadata: {
            user_id: current_user.id,
            fish_id: @fish.id
        }
      },
      success_url: root_url + "orders/success",
      cancel_url: root_url + "fish",
    )

    @session_id = session.id
  end

  # GET /fish/new
  def new
    @fish = Fish.new
  end

  # GET /fish/1/edit
  def edit
  end

  # POST /fish
  # POST /fish.json
  def create
    @fish = Fish.new(fish_params)
    @fish.user_id = current_user.id

    respond_to do |format|
      if @fish.save
        format.html { redirect_to @fish, notice: 'Fish was successfully created.' }
        format.json { render :show, status: :created, location: @fish }
      else
        format.html { render :new }
        format.json { render json: @fish.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fish/1
  # PATCH/PUT /fish/1.json
  def update
    respond_to do |format|
      if @fish.update(fish_params)
        format.html { redirect_to @fish, notice: 'Fish was successfully updated.' }
        format.json { render :show, status: :ok, location: @fish }
      else
        format.html { render :edit }
        format.json { render json: @fish.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fish/1
  # DELETE /fish/1.json
  def destroy
    @fish.destroy
    respond_to do |format|
      format.html { redirect_to fish_index_url, notice: 'Fish was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fish
      @fish = Fish.find(params[:id])
    end

    def set_user_fish
      @fish = current_user.fish.find_by_id(params[:id])

      if @fish == nil
        redirect_to fish_index_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fish_params
      params.require(:fish).permit(:name, :description, :price, :user_id)
    end

    def translate_params
      params[:fish][:price] = (params[:fish][:price].to_f * 100).to_i
    end
end
