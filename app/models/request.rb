# == Schema Information
#
# Table name: requests
#
#  id                     :integer         not null, primary key
#  recipient_name         :string(255)
#  recipient_title        :string(255)
#  recipient_organization :string(255)
#  recipient_addr         :string(255)
#  recipient_city         :string(255)
#  recipient_state        :string(255)
#  recipient_zip          :string(255)
#  request_text           :text
#  user_id                :integer
#  request_type_id        :integer
#  created_at             :datetime        not null
#  updated_at             :datetime        not null
#  letter                 :text
#

class Request < ActiveRecord::Base
  before_create :generate_letter
  after_create  :status_pending

	belongs_to :user
	belongs_to :request_type
  has_many :statuses
  attr_accessible :recipient_addr, :recipient_city, :recipient_name,
                  :recipient_organization, :recipient_state,
                  :recipient_title, :request_type_id, :recipient_zip,
                  :request_text, :letter
                  
  liquid_methods :recipient_name, :recipient_title, :recipient_organization,
                 :recipient_addr, :recipient_city, :recipient_state,
                 :recipient_zip, :request_text, :created_at, :user_name,
                 :user_email, :user_phone, :user_title, :user_organization,
                 :user_address, :user_city, :user_state, :user_zip

  validates :user_id,         presence: true
  validates :recipient_name,  presence: true
  validates :recipient_addr,  presence: true
  validates :recipient_city,  presence: true
  validates :recipient_state, presence: true, length: { maximum: 2, minimum: 2 }
  validates :recipient_zip,   presence: true
  validates :request_type_id, presence: true
  default_scope order: 'requests.created_at DESC'

  delegate :template, to: :request_type
  delegate :name, :email, :phone, :title, :organization,
           :address, :city, :state, :zip,
           to: :user, prefix: true

  def generate_letter
    self.letter =  Liquid::Template.parse(template).render('request' => self)
  end

  def current_status
    statuses.first
  end

  def is_in_violation?
    current_status.status == 'sent' &&
      3.business_days.after(current_status.created_at.to_date).past?
  end

  def sent?
    statuses.where("status_events.status_name = 'sent'").joins(:status_event).count == 1
  end

  def response_received?
    statuses.where("status_events.status_name = 'response received'").joins(:status_event).count == 1
  end

  protected

    def status_pending
      statuses.create( status_event_id: 1 )
      self.letter =  Liquid::Template.parse(template).render('request' => self)
      self.save
    end
end
