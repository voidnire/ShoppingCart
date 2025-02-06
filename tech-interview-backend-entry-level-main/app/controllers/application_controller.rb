class ApplicationController < ActionController::API
    rescue_from ActionController::RoutingError, with: :route_not_found

    private

    def route_not_found
        render json: { error: "Rota não encontrada" }, status: :not_found
      end
    
end
