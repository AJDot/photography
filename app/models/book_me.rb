class BookMe
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :name, :phone, :email, :event_date, :event_type, :message

  validates_presence_of :name, :email, :event_date, :event_type, :message
  validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

  def persisted?
    false
  end

  def event_date=(date)
    return if date.blank?
    @event_date = Time.new(date)
  end
end
