module ActiveRecordExpander
  extend ActiveSupport::Concern
  included do
    def new_record?(strict = false)
      if strict
        self.class.validated_attributes_on(:presence).map { |attr|
         self.send(attr).nil?
        }.exclude?(false)
      else
        super()
      end
    end

    def self.validated_attributes_on(type)
      key =  "#{type.to_s.camelize}Validator"

      begin
        validator = const_get(key)
      rescue NameError
        raise ArgumentError, "Unknown validator: #{key}"
      end

      _validators.map do |attr, validators|
        attr if validators.map(&:class).include?(validator)
      end
    end
  end
end
