class Proto < ApplicationRecord
  belongs_to :user
  has_many :images
  has_one :main_image, -> { where role: 'main' }, class_name: 'Image'
  accepts_nested_attributes_for :images, allow_destroy: true

  validates :title, :catchcopy, :concept, presence: true
  after_initialize :build_main_image, :build_sub_images, if: -> { new_record?(true) }

  def sub_images
    images.select(&:sub?)
  end

  def new_record?(strict = false) #defaultだとfalseなので、trueを渡して裏で定義されているのを呼ばれないようにする
    if strict
      id.nil? && !self.class.validated_attributes_on(:presence).map { |attr|
      # self.class.validated_attributes_on(:presence) => [ :user, :title, :catchcopy, :concept]
        self.send(attr).nil?
        # sendメソッドは、レシーバの持っているメソッドを呼び出す
      }.include?(false)
    else
      super() #defaultの裏で定義されているnew_record?を呼ぶ
    end
  end

  private

  def self.validated_attributes_on(type) #typeにはvalidationの種類が渡される
    validator = case type
                when :absence    then ActiveRecord::Validations::AbsenceValidator
                when :associated then ActiveRecord::Validations::AssociatedValidator
                when :length     then ActiveRecord::Validations::LengthValidator
                when :presence   then ActiveRecord::Validations::PresenceValidator #今回の場合は←が渡される
                when :uniqueness then ActiveRecord::Validations::UniquenessValidator
                else raise
                end

    _validators.map do |attr, validators|
      attr if validators.map(&:class).include?(validator) #=ActiveRecord::Validations::PresenceValidator
    end
    # _validatorsの中身
       # {:user=>
       #  [#<ActiveRecord::Validations::PresenceValidator:0x007fe4d39c73d0
       #    @attributes=[:user],
       #    @options={:message=>:required}>], validatorsに入る
       # :title=>
       #  [#<ActiveRecord::Validations::PresenceValidator:0x007fe4d0c77fb0
       #    @attributes=[:title, :catchcopy, :concept],
       #    @options={}>],
       # :catchcopy=>
       #  [#<ActiveRecord::Validations::PresenceValidator:0x007fe4d0c77fb0
       #    @attributes=[:title, :catchcopy, :concept],
       #    @options={}>],
       # :concept=>
       #  [#<ActiveRecord::Validations::PresenceValidator:0x007fe4d0c77fb0
       #    @attributes=[:title, :catchcopy, :concept],
       #    @options={}>]}
#    validators.map(&:class) => [ActiveRecord::Validations::PresenceValidator]
#    validator => ActiveRecord::Validations::PresenceValidator
#    attr => :user
#   _validators.map do |attr, validators| => [ :user, :title, :catchcopy, :concept]
  end

  def build_main_image
    images << Image.new(role: :main)
  end

  def build_sub_images
    Settings[:SUB_IMAGES_NUMBER].times { images << Image.new(role: :sub) }
  end
end
