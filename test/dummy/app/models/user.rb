class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #TODO HZ:: add logic here!
  def is_admin?
    self.admin
  end

  def is_reservable?
  	if self.is_a? Patient
  		return false
  	end
  	true
  end

  def is_customer?
  	if self.is_a? Patient
  		return true
  	end
  	false
  end

end