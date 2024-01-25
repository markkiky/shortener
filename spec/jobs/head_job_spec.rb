# frozen_string_literal: true

require 'rails_helper'

# RSpec.describe Links::HeadJob, type: :job do
#   describe '#perform_async' do
#     it 'enqueues the job' do
#       link = create(:link)
#       expect do
#         Links::HeadJob.perform_async(link.id)
#       end.to change(Sidekiq::Queue.new('default'), :size).by(1)
#     end
#   end

#   describe '#perform' do
#     it 'performs the job' do
#       link = create(:link) # Use the factory to create a link instance
#       expect_any_instance_of(Link).to receive(:find).with(link.id).and_return(link)

#       Links::HeadJob.new.perform(link.id)
#     end
#   end
# end

RSpec.describe Links::HeadJob, type: :job do
  include ActiveJob::TestHelper

  describe '#perform' do
    it 'returns true' do
      link = create(:link)
      result = Links::HeadJob.new.perform(link.id)
      expect(result).to eq(true)
    end
  end

  describe '#perform_async' do
    subject(:job) { Links::HeadJob.perform_async(create(:link).id) }

    it 'queues the job' do
      expect { :job }.to change(Sidekiq::Queues['default'], :size).by(1)
    end
  end
end
