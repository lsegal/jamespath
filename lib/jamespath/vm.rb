module Jamespath
  # @note This class is not thread-safe.
  class VM
    # @api private
    class ArrayGroup < Array
      def initialize(arr) replace(arr) end
    end

    attr_reader :instructions

    def initialize(instructions)
      @instructions = instructions
    end

    def search(object_to_search)
      object = object_to_search
      @instructions.each do |instruction|
        if instruction.first == :ret_if_match
          if object
            break # short-circuit or expression
          else
            object = object_to_search  # reset search
          end
        else
          object = send(instruction[0], object, instruction[1])
        end
      end

      object
    end

    protected

    def get_key(object, key)
      if struct?(object)
        object[key]
      elsif ArrayGroup === object
        object = object.map {|o| get_key(o, key) }.compact
        object.length > 0 ? ArrayGroup.new(object) : nil
      end
    end

    def get_idx(object, idx)
      if ArrayGroup === object
        object = object.map {|o| get_idx(o, idx) }.compact
        object.length > 0 ? ArrayGroup.new(object) : nil
      elsif array?(object)
        object[idx]
      end
    end

    def get_key_all(object, *)
      object.respond_to?(:values) ? ArrayGroup.new(object.values) : nil
    end

    def get_idx_all(object, *)
      if array?(object)
        new_object = object.map do |o|
          Array === o ? ArrayGroup.new(o) : o
        end
        ArrayGroup.new(new_object)
      elsif object.respond_to?(:keys)
        ArrayGroup.new(object.keys)
      elsif object.respond_to?(:members)
        ArrayGroup.new(object.members.map(&:to_s))
      end
    end

    private

    def struct?(object)
      Hash === object || Struct === object
    end

    def array?(object)
      Array === object
    end
  end
end
