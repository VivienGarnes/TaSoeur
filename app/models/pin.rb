class Pin < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }

  acts_as_votable

  validates :description, presence: true, length: { maximum: 256 }
end
