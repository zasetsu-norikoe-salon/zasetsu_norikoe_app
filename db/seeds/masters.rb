# frozen_string_literal: true

files = %w[skill_categories skill_sets]

ActiveRecord::Base.transaction do
  files.each do |file|
    require Rails.root.join('db', 'seeds', 'masters', file)
  end
end
