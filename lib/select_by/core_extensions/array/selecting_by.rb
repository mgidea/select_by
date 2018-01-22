module SelectBy
  module CoreExtensions
    module Array
      module SelectingBy
        SELECTING_METHODS = [:select, :reject, :detect, :partition, :find_all, :find]

        class InvalidArgumentError < StandardError
          def message
            "method argument or hash key must respond to to_s"
          end
        end

        class InvalidSelectingMethodError < StandardError
          def message
            "Only #{SELECTING_METHODS} methods can be passed to private method: :selecting_by"
          end
        end
        # if a hash is provided use each hash key as a method name and value as what the method should return
        # if any of key/value pairs are not callable or do not match the reciever based on equality then reject
        # the element of the array.  if argument that is provided is a callable method (calling to_s on the object
        # returns a method the element responds to) then call that method on each element only returning the elements
        # that return a truthy value (similar to select(&:method)).
        # if you provide a code block the method will apply that code block to each returned element

        def select_by(hash_or_method = nil, &block)
          select_or_reject_by(:select, hash_or_method, &block)
        end

        # works the same as select_by but returns elements that do not evaluate to true
        def reject_by(hash_or_method = nil, &block)
          select_or_reject_by(:reject, hash_or_method, &block)
        end

        def partition_by(hash_or_method = nil, &block)
          array = if hash_or_method.nil?
                  [self, []]
                else
                  selecting_by(:partition, hash_or_method)
                end

          block_given? ? array.map{|inner_array| inner_array.map(&block)} : array
        end

        def detect_by(hash_or_method = nil, &block)
          array = if hash_or_method.nil?
                  self
                else
                  selecting_by(:select, hash_or_method, true)
                end

          (block_given? ? array.map(&block) : array).first
        end

        alias_method :find_by, :detect_by
        alias_method :find_all_by, :select_by
        private

        def selecting_by(meth, hash_or_method, stop_first_time = false)
          raise InvalidArgumentError unless (meth.respond_to?(:to_sym))
          raise InvalidSelectingMethodError unless SELECTING_METHODS.include?(meth.to_sym)

          send(meth) do |obj|
            case hash_or_method
            when Hash
              val = hash_or_method.all? do |key, value|
                raise InvalidArgumentError.new unless key.respond_to?(:to_s)
                obj.respond_to?(key.to_s) && obj.send(key.to_s) == value
              end
              return [obj] if val && stop_first_time
              val
            else
              raise InvalidArgumentError.new unless hash_or_method.respond_to?(:to_s)
              val = obj.respond_to?(hash_or_method.to_s) && obj.send(hash_or_method.to_s)
              return [obj] if val && stop_first_time
              val
            end
          end
        end
      end
    end
  end
end
