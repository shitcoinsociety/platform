class Wallet < ApplicationRecord
  JSON_OPTIONS = {
    only: [ :id, :address, :type ]
  }

  belongs_to :user, optional: true

  validates :address, presence: true, uniqueness: { scope: :type }
  validates :index, presence: true, uniqueness: { scope: :type }

  def self.for(subclass)
    where(type: "Wallet::#{subclass.capitalize}")
  end

  def initialize(attributes = {})
    super
    set_index
    set_address
  end

  private

  def set_address
    # This method should be implemented in subclasses
    raise NotImplementedError, "Subclasses must implement a set_address method"
  end

  def set_index
    self.index ||= Wallet.where(type: type).count
  end
end
