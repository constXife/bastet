module API
  class SensorsController < ApplicationController
    before_action :set_sensor, only: [:update, :destroy]

    has_scope :daily

    def index
      @sensors = Sensor.all
    end

    def create
      @sensor = Sensor.find_or_create_by!(sid: sensor_params['id'].to_i)

      sensor = ::Sensor.find_or_create_by!(sid: sensor_params['id'].to_i)
      sensor_data_hash = {
          sensor_id: sensor.id,
          value: data['value'].to_f,
          data_type: data['type'],
          raw_data: data.to_json
      }
      SensorData.create!(sensor_data_hash)

      result = JSON.parse(render_to_string(template: 'api/sensors/show.json'))
      $redis.publish 'dashboard', result.to_json

      respond_with(@sensor, :created)
    end

    def show
      @sensor = Sensor.find(params[:id])
      @sensor_data = apply_scopes(SensorDatum).where(sensor_id: @sensor.id)
    end

    def update
      respond_with(@sensor)
    end

    def destroy
      @sensor.destroy

      respond_with(@sensor)
    end

  private

    def sensor_params
      params.require(:sensor).permit(:id, :sid)
    end

    def set_sensor
      @sensor = Sensor.find(params[:id])
    end
  end
end