module API
  # Sensors controller
  class SensorsController < ApplicationController
    before_action :set_sensor, only: [:update, :destroy]
    skip_before_filter :verify_authenticity_token, :only => [:create]
    respond_to :json

    has_scope :daily

    # List of sensors
    def index
      @sensors = Sensor.all
    end

    # Receive data from sensors and store it
    def create
      @sensor = Sensor.find_or_create_by!(sid: sensor_params['sid'].to_i)

      sensor_data_hash = {
          sensor_id: @sensor.id,
          value: sensor_params['value'].to_f,
          data_type: sensor_params['type'],
          raw_data: sensor_params.to_json
      }
      SensorDatum.create!(sensor_data_hash)

      result = JSON.parse(render_to_string(template: 'api/sensors/show.json'))
      $redis.publish 'dashboard', result.to_json

      respond_with(@sensor, :created)
    end

    # Show sensor
    def show
      @sensor = Sensor.find(params[:id])
      @sensor_data = apply_scopes(SensorDatum).where(sensor_id: @sensor.id)
    end

    # Update sensor
    def update
      respond_with(@sensor)
    end

    # Destroy sensor
    def destroy
      @sensor.destroy

      respond_with(@sensor)
    end

  private

    def sensor_params
      params.require(:sensor).permit(:id, :sid, :value, :type)
    end

    def set_sensor
      @sensor = Sensor.find(params[:id])
    end
  end
end