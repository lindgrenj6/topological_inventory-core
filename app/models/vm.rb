require "archived_concern"

class Vm < ApplicationRecord
  include ArchivedConcern

  belongs_to :tenant
  belongs_to :source
  belongs_to :orchestration_stack, :optional => true
  belongs_to :flavor, :optional => true

  has_many :volumes, :through => :volume_attachments
  has_many :volume_attachments

  acts_as_taggable
end