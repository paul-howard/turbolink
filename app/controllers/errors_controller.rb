class ErrorsController < ApplicationController
  def file_not_found
    # 404
  end

  def unprocessable
    # 422
  end

  def internal_server_error
    # 500
  end
end
