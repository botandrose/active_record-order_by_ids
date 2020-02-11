require "active_record/order_by_ids/version"
require "active_record"

module ActiveRecord
  module OrderByIds
    def order_by_ids ids
      fragments = []
      fragments += ["#{primary_key} NOT IN (#{ids.map(&:to_s).join(",")})"] if ids.any?
      fragments += ids.reverse.map { |id| "#{primary_key}=#{id}" }
      reorder(Arel.sql(fragments.join(", ")))
    end
  end
end

ActiveRecord::Base.extend ActiveRecord::OrderByIds
