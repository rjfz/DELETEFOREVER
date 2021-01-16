# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :commenter, class_name: 'User'
  validates :body, presence: true, length: { minimum: 3 }
end
