require 'objspace'
require "iseq_collector/version"

case
when RUBY_VERSION < '2.3.0'
  module ObjectSpace
    def self.each_iseq
      ObjectSpace.each_object(RubyVM::InstructionSequence){|iseq|
        yield iseq
      }
    end
    def self.count_iseq
      cnt = 0
      ObjectSpace.each_object(RubyVM::InstructionSequence){|iseq|
        cnt += 1
      }
      cnt
    end
  end
when RUBY_VERSION >= '2.3.0' && RUBY_VERSION < '2.5.0'
  require_relative 'iseq_collector.so'
when RUBY_VERSION == '2.5.0'
  unless ObjectSpace.respond_to? :count_iseq
    require_relative 'iseq_collector.so'
  end
  # do nothing.
end

module ObjectSpace
  def self.memsize_of_all_iseq
    size = 0
    ObjectSpace.each_iseq{|iseq|
      size += ObjectSpace.memsize_of(iseq)
    }
    size
  end
end

module IseqCollector
  # we have no code here.
end
