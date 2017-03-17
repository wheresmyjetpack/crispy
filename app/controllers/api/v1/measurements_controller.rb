module Api
  module V1
    class MeasurementsController < ApplicationController

      def index
        measurement = params[:measurement]
        valid_measurement = begin
                              Measurement.parse(measurement)
                            rescue
                              ArgumentError
                              false
                            else
                              true
                            end
        respond_to do |format|
          headers['Last-Modified'] = Time.now.httpdate
          format.json { render json: valid_measurement }
        end
      end
    end
  end
end
