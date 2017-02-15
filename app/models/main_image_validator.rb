class MainImageValidator < ActiveModel::Validator
  def validate(record)
    main_image = record.images.find(&:main?)
    return if main_image.valid?
    record.errors.add(:proto, 'main image is necessarry')
  end
end
