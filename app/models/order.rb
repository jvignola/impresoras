class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :product
  belongs_to :review_comprador, :class_name => 'Review'
  belongs_to :review_vendedor, :class_name => 'Review'

  scope :mias, -> (id) { where(user: id) }
  scope :sin_autorizar, -> { where(autorizado: false) }
  scope :sin_entregar, -> { where(autorizado: true, entregado: false) }
  scope :entregadas, -> { where(entregado: true) }
  #scope :entregadas, -> { where(entregado:true).where(review_comprador_id:nil).or.where(review_vendedor_id:nil)}
  #scope :sin_comentar, -> {where(review_comprador_id:nil).where(review_vendedor_id:nil).where_values.join(' OR ')}


  def self.entregadas_sin_comentar
    entregadas = Order.entregadas
    sin_comentar_vendedor = Order.where(review_vendedor_id:nil)
    sin_comentar_comprador = Order.where(review_comprador_id:nil)
    sin_comentar_alguno = sin_comentar_comprador | sin_comentar_vendedor
    entregadas & sin_comentar_alguno
  end

  def self.entregadas_y_comentadas
    entregadas = Order.entregadas
    comentadas_vendedor = Order.where.not(review_vendedor_id:nil)
    comentadas_comprador = Order.where.not(review_comprador_id:nil)
    entregadas & comentadas_comprador & comentadas_vendedor
  end 


  def autorizar
  	self.update(autorizado: true, fecha_autorizado: DateTime.now)
  end
  def entregar
  	self.update(entregado: true, fecha_entregado: DateTime.now)
  end
end
