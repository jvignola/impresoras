class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

#scope :find_lazy, -> (id) { where(:id => id) }

  scope :mias, -> (id) { where(user: id) }
  scope :sin_autorizar, -> { where(autorizado: false) }
  scope :sin_entregar, -> { where(autorizado: true, entregado: false) }
  scope :entregadas, -> { where(entregado: true) }
end
