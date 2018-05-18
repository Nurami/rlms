class Learner < ApplicationRecord
  devise :confirmable,
         :database_authenticatable,
         :lockable,
         # :omniauthable,
         :recoverable,
         :registerable,
         :rememberable,
         :timeoutable,
         :trackable,
         :validatable

  has_many :course_participations
  has_many :courses, through: :course_participations
  has_many :learner_answers

  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def available_courses
    Course.where.not(id: courses.ids).published.ordered_by_title
  end
end
