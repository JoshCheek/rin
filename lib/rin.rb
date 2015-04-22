def rin
  Rin.instance
end

class Rin
  def self.instance
    @instance ||= new(10)
  end

  def initialize(base)
    @base = base
    Fixnum.class_eval do
      define_method :inspect do
        Rin.instance.inspect_num self
      end
    end
  end

  def inspect_num(n)
    n.to_s(@base).upcase
  end

  def hex(&block)
    temporary_override 16, &block
  end

  def oct(&block)
    temporary_override 8, &block
  end

  def bin(&block)
    temporary_override 2, &block
  end

  def dec(&block)
    temporary_override 10, &block
  end

  private

  def temporary_override(overriden_base, &block)
    initial_base = @base
    @base = overriden_base
    block.call
    @base = initial_base
  end
end
