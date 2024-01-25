# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Link, type: :model do
  subject { build(:link, user: build(:user)) }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid with a user' do
    subject.user = nil
    expect(subject).to_not be_valid
  end

  it 'is not valid without a url' do
    subject.url = nil
    expect(subject).to_not be_valid
  end

  it 'generates a short code before validation' do
    subject.valid?
    expect(subject.short_code).to be_present
  end
end
