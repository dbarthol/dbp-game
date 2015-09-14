class ShipsController < ApplicationController
  before_action :set_ship, only: [:cheat, :show, :edit, :update, :destroy]

  def cheat
    @ship.metal = @ship.metal + 100000000
    @ship.cristal = @ship.cristal + 100000000
    @ship.fuel = @ship.fuel + 100000000

    @ship.save

    redirect_to ships_url
  end
  
  # GET /ships
  # GET /ships.json
  def index
    @ships = Ship.all
  end

  # GET /ships/1
  # GET /ships/1.json
  def show
  end

  # GET /ships/new
  def new
    @ship = Ship.new
  end

  # GET /ships/1/edit
  def edit
  end

  # POST /ships
  # POST /ships.json
  def create
    
    @ship = current_user.create_ship(ship_params)
    

    respond_to do |format|
      if @ship!=nil
        current_user.activeShip = @ship.id
        if @ship.save
          format.html { redirect_to @ship, notice: 'Ship was successfully created.' }
          format.json { render :show, status: :created, location: @ship }
        else
          format.html { render :new }
          format.json { render json: @ship.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to ships_path, notice: 'Kauf nicht erfolgreich!' }
        
      end
    end
  end

  # PATCH/PUT /ships/1
  # PATCH/PUT /ships/1.json
  def update
    respond_to do |format|
      if @ship.update(ship_params)
        format.html { redirect_to @ship, notice: 'Ship was successfully updated.' }
        format.json { render :show, status: :ok, location: @ship }
      else
        format.html { render :edit }
        format.json { render json: @ship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ships/1
  # DELETE /ships/1.json
  def destroy
    @ship.destroy
    respond_to do |format|
      format.html { redirect_to ships_url, notice: 'Ship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ship
      @ship = Ship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ship_params
      params.require(:ship).permit(:name, :ships_id, :stations_id, :level, :activeShip)
    end
end
