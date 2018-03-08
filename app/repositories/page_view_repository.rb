class PageViewRepository

  def find(options)
    @options = options
    client.search(build_entry)
  end

  private

  attr_reader :client, :options


  def build_entry
    {
      body: {
        query: {
          stats: filter, range: range
        },
        aggs: interval
      }
    }
  end

  def filter
    {
      filter: {
        terms: {
          page_url: options[:urls]
        }
      }
    }
  end

  def range
    {
      time_frame: {
        gte: options[:after],
        lte: options[:before],
        relation: 'within',
        format: 'epoch_millis'
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