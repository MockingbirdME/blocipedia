class Wiki < ActiveRecord::Base
  belongs_to :user

  validates :title, length: {minimum: 2}, presence: true
  validates :body, length: {minimum: 10}, presence: true
  validates :user, presence: true

  default_scope {order('lower(title)')}
end
