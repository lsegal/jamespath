require 'minitest/autorun'
require_relative '../lib/jamespath'

describe "Struct" do

  it "treats struct objects like hashes" do
    struct_class = Struct.new(:foo, :bar)
    data = struct_class.new(struct_class.new(nil, 'yuck'), nil)
    Jamespath.search('foo.bar', data).must_equal('yuck')
  end

  it "can select all values from a struct" do
    struct_class = Struct.new(:foo, :bar)
    data = struct_class.new(nil, struct_class.new('f', 'b'))
    Jamespath.search('bar.*', data).must_equal(['f', 'b'])
  end

end
