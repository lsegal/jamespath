module Jamespath
  class VM
    attr_reader :instructions

    def initialize(instructions)
      @instructions = instructions
    end

    def search(object)
      @ret_flag = false
      @orig_objects = @objects = [object]
      @instructions.each do |instruction|
        break if @ret_flag
        send(*instruction)
      end
      @objects.size <= 1 ? @objects.first : @objects
    end

    def get_key(key)
      @objects = @objects.map {|obj| Hash === obj ? obj[key] : nil }.compact
    end

    def get_idx(idx)
      @objects = @objects.map {|obj| Array === obj ? obj[idx] : nil }.compact
    end

    def get_key_all(*)
      objs = []
      @objects.each {|obj| objs += obj.values if Hash === obj }
      @objects = objs
    end

    def get_idx_all(*)
      objs = []
      @objects.each {|obj| objs += obj if Array === obj }
      @objects = objs
    end

    def ret_if_match(*)
      if @objects.size > 0
        @ret_flag = true
      else
        @objects = @orig_objects
      end
    end
  end
end
