class Interaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  belongs_to :interaction

  scope :respondidas, -> { where(respondida: true) }
  scope :sin_responder, -> { where(respondida: false) }

end
