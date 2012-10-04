class Post < ActiveRecord::Base
  attr_accessible :body, :title, :user_id
  has_many :comments, dependent: :destroy
  belongs_to :user
  validates :title, :presence =>true
  validates :body, :presence =>true
end
