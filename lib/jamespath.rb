require_relative './jamespath/tokenizer'
require_relative './jamespath/parser'
require_relative './jamespath/vm'
require_relative './jamespath/version'

module Jamespath
  module_function

  def search(query, object)
    if String === object
      require 'json'
      object = JSON.parse(object)
    end

    compile(query).search(object)
  end

  def compile(query)
    VM.new(Parser.new.parse(query))
  end
end
