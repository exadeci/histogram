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
          bool: {
            must: [
              terms, range
            ]
          }
        },
        aggs: interval
      }
    }
  end

  def terms
    {
      terms: {
        page_url: options.urls
      }

    }
  end

  def range
    {
      range: {
        derived_tstamp: {
          gte: options.after,
          lte: options.before,
          relation: 'within',
          format: 'epoch_millis'
        }
      }
    }
  end

  def interval
    {
      stats: {
        date_histogram: {
          field: 'derived_tstamp',
          interval: options.interval.presence || '10m'
        }
      }
    }
  end

  def client
    @client = Elasticsearch::Client.new(log: true)
  end
end