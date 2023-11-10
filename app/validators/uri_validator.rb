class UriValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless uri_valid?(value)
      record.errors.add attribute, (options[:message] || "must be a valid URI")
    end
  end

  def uri_valid?(uri)
    uri = URI.parse(uri)
    uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
  rescue
    false
  end
end
