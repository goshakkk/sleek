module Sleek
  class QueryCollection
    attr_reader :namespace

    # Inernal: Initialize query collection.
    #
    # namespace - the Sleek::Namespace object.
    def initialize(namespace)
      @namespace = namespace
    end

    # Define method for each query
    [:count, :count_unique, :minimum, :maximum, :sum, :average].each do |name|
      klass = "Sleek::Queries::#{name.to_s.camelize}".constantize

      define_method(name) do |bucket, options = {}|
        QueryCommand.new(klass, namespace, bucket, options).run
      end
    end

    def inspect
      "#<Sleek::QueryCollection ns=#{namespace.name}>"
    end
  end
end
