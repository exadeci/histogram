class PageViewRepository

  def self.find(options)
    @options = options
    @client.search(build_entry)
  end

  private

  attr_reader :client, :options

  class << self

    def build_entry
      {
        body: {
          query: range,
          aggs: interval
        }
      }
    end

    def range
      {
        range: {
          time_frame: {
            gte: options[:after].presence || 1.month.ago,
            lte: options[:before].presence || Time.current,
            relation: 'within'
          }
        }
      }
    end

    def interval
      {
        stats: {
          date_histogram: {
            field: 'derived_tstamp',
            interval: options[:before].presence || '10m'
          }
        }
      }
    end

    def client
      @client = Elasticsearch::Client.new(log: true)
    end
  end
end