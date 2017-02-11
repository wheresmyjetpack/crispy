module ShoppingItems
  class SaveItems < Rectify::Command
    def initialize(items, query: Ingredients::Form, repo: Ingredients::Repository.new)
      @items = normalize_keys(items)
      @query = query
      @repo = repo
    end

    def call
      return broadcast(:ok) if persist(project_to_querys)
      broadcast(:invalid)
    end

    private

    attr_reader :items, :repo, :query

    def normalize_keys(params)
      params.map(&:symbolize_keys)
    end

    def project_to_querys
      items.map { |item| new_query(**parse_measurement(item)) }
    end

    def persist(records)
      records.each { |record| repo.write(record) }
    end

    def new_query(record)
      query.new(record)
    end

    def parse_measurement(item)
      measure = item.fetch(:amount).to_measurement
      item[:unit] = measure.unit
      item[:amount] = measure.quantity
      new_query(**item)
    end
  end
end
