class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  after_create :async_update # Run on create & update

  private

  def async_update
    # esse é um metodo de instancia então enviamos o user como self
    UpdateUserJob.perform_later(self)
  end
end
