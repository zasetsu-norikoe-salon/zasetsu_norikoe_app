# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before do
    assign(:users, [
             create(:user),
             create(:user)
           ])
  end

  it 'renders a list of users' do
    render
  end
end
