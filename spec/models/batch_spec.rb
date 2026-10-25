require 'rails_helper'

# == Schema Information
#
# Table name: batches
# Database name: primary
#
#  id            :bigint           not null, primary key
#  codename      :string
#  file          :string
#  source_locale :string
#  state         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  game_id       :integer
#
RSpec.describe Batch, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
