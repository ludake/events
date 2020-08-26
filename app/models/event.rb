class Event < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :categories
  has_many :registrations
  has_many :attendees, :through => :registrations, :source => :user
  
  
  validates_presence_of :title, :location
  
  validate     :has_not_occurred

  validates     :image_url, allow_blank: true, format: {
    with:        %r{\.(gif|jpg|png)\z}i,
    message:     'Must be a URL for GIF, JPG, or PNG image.'            
  }
  
  after_create :ensure_owner_attends
  
  acts_as_taggable
  acts_as_taggable_on :skills, :interests
  
  
  def is_in_the_past?
    occurs_on < Date.today
  end
  
  def long_title
    "#{title} - #{location} - #{occurs_on}"
  end
  
  def owned_by?(owner)
    return false unless owner.is_a? User
    user == owner
  end
    
  
  protected
    def ensure_owner_attends
      unless attendees.include? user
        attendees << user
      end
    end

  
  def has_not_occurred
    errors.add("occurs_on",I18n.t('is in the past')) if occurs_on && is_in_the_past?
  end
  
      
end
