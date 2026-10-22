class ErrorSerializer
  def initialize(errors, status)
    @errors = errors
    @status = status
  end

  def serialize
    {
      errors: @errors.map do |error|
        {
          status: @status.to_s,
          title: error.full_message,
          detail: error.message
        }
      end
    }
  end
end
