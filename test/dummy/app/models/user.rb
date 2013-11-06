class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # TODO HZ: provided by user
  def is_reservable?
    if self.is_a? Patient
      return false
    end
    true
  end

  # TODO HZ: provided by user
  def is_customer?
    if self.is_a? Patient
      return true
    end
    false
  end

  # TODO HZ: provided by user
  def is_admin?
    self.admin
  end

  # TODO HZ: provided by user
  def can_find_customers?
    self.admin
  end

  # TODO HZ: provided by user
  def allow_notification?
    true
  end

end