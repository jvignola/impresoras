module PermissionsConcern
	extend ActiveSupport::Concern

	def is_normal_user?
		self.permission_level >= 100
	end

	def is_authorized_user?
		self.permission_level >= 200
	end

	def is_admin_user?
		self.permission_level >=300
	end
end