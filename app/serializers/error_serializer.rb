class ErrorSerializer
  def initialize(error)
    @error = error
  end

  def serialize_missing_market_json
    {
        errors: [
        {
          status: "404",
          detail: @error.message
        }
      ]
    }
  end
end