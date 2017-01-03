class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true

  scope :visible_to, -> (user){ ((user.premium?) || (user.admin?)) ? where(private: [false, nil]) + where(private: true, user: user) : where(private: [false, nil]) }

end
