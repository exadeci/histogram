require 'rails_helper'

RSpec.describe PageViewRepository, type: :model do
  let(:expected_hash) {{:body =>
                          {:query =>
                             {:bool =>
                                {:must =>
                                   [{:terms => {:page_url => ["http://test.com"]}},
                                    {:range =>
                                       {:derived_tstamp =>
                                          {:gte => 1488340603000,
                                           :lte => 1520469267124,
                                           :relation => "within",
                                           :format => "epoch_millis"}}}]}},
                           :aggs =>
                             {:stats =>
                                {:date_histogram => {:field => "derived_tstamp", :interval => "1h"}}}}}}

  let(:repository) {described_class.new}
  let(:arguments_object) {OpenStruct.new(urls: ['http://test.com'], before: 1520469267124, after: 1488340603000, interval: '1h')}

  describe '#find' do

    it 'calls search on elastic' do
      expect_any_instance_of(Elasticsearch::Transport::Client).to receive(:search).with(expected_hash).and_return(true)
      expect(repository.find(arguments_object)).to eq(true)
    end
  end
end