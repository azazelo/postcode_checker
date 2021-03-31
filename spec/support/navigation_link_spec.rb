# frozen_string_literal: true

require 'spec_helper'
require 'pry'

RSpec.shared_examples 'Navigation link' do |link_text, content|
  it 'implemets the main navigations link' do
    expect(page).to have_content link_text
    click_link link_text
    expect(page).to have_content content
  end
end
