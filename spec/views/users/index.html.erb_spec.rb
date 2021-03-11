# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/index', type: :view do
  before do
    create_list(:user, 15)
    assign(:users, User.page(1))
  end

  it 'renders a list of users' do
    render
  end
end
