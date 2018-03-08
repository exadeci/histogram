class PageViewValidation
  include ActiveModel::Validations

  attr_accessor :after, :before, :urls, :interval

  validates :after, :before, presence: true, numericality: true
  validates :after, :before, length: {is: 13, message: 'must be in epoch milliseconds '}

  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end

end