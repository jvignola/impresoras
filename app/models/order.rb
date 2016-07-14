class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :product

  scope :mias, -> (id) { where(user: id) }
  scope :sin_autorizar, -> { where(autorizado: false) }
  scope :sin_entregar, -> { where(autorizado: true, entregado: false) }
  scope :entregadas, -> { where(entregado: true) }

  def autorizar
  	self.update(autorizado: true, fecha_autorizado: DateTime.now)
  end
  def entregar
  	self.update(entregado: true, fecha_entregado: DateTime.now)
  end
end
