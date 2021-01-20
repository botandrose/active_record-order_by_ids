require "active_record/order_by_ids/version"
require "active_record"

module ActiveRecord
  module OrderByIds
    def order_by_ids ids
      order_by(primary_key => ids)
    end

    def order_by hash
      hash.reduce(reorder(false)) do |scope, (key, ids)|
        ids.map! { |id| connection.quote(id) }
        fragments = []
        fragments += ["#{key} NOT IN (#{ids.join(",")}) OR #{key} IS NULL"] if ids.any?
        fragments += ids.reverse.map { |id| "#{key}=#{id}" }
        scope.order!(Arel.sql(fragments.join(", ")))
      end
    end
  end
end

ActiveRecord::Base.extend ActiveRecord::OrderByIds
