class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable


  has_many :wikis

  enum role: [:standard, :premium, :admin]
  after_initialize(:set_default_role, {if: :new_record?})

  def set_default_role
    self.role ||= :standard
  end

  def change_user_role(new_role)
    update_attribute(:role, new_role)
  end

  def save_subscription(sub)
    update_attribute(:subscription, sub)
  end

  def delete_subscription
    update_attribute(:subscription, nil)
  end

  def cancel_privates
    puts "hi there"
    self.wikis.each { |wiki| puts wiki.set_as_public }
  end

  def avatar_url(size)
    gravatar_id = Digest::MD5::hexdigest(self.email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

end
