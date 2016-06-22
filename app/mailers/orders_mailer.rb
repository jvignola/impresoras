class OrdersMailer < ApplicationMailer

  include Rails.application.routes.url_helpers
  helper ActionView::Helpers::UrlHelper

  def pedido_para_autorizar(pedido)
  	# envia mail al autorizador de un pedido, informando que debe ingresar a autorizar
  	@pedido = pedido
  	mail(to: pedido.user.user.email, subject:'Nuevo pedido para autorizar')	
  end

  def nuevo_pedido_autorizado(pedido)
  	# envia mail a los administradores del sitio, informando que ingresó un nuevo pedido 
  	# autorizado o se autorizó un pedido normal
  	@pedido = pedido
  	User.administradores.each do |admin|
  		mail(to: admin.email, subject:'Nuevo pedido autorizado')
  	end	
  end

  def nueva_pregunta(pregunta)
  	# envia mail a los administradores del sitio, informando que llegó una nueva pregunta
  	@pregunta = pregunta
  	User.administradores.each do |admin|
  		mail(to: admin.email, subject:'Nueva pregunta realizada')
  	end	
  end

  def nueva_respuesta(pregunta)
  	# envia mail al autor de la pregunta para avisarle que ya tiene la respuesta
  	@pregunta = pregunta
  	mail(to: pregunta.user.email, subject:'Su pregunta ha sido respondida')
  end

end
