def rin
  Rin.instance
end

class Rin
  def self.instance
    @instance ||= begin
      instance = new(10)
      instance.enable!
      instance
    end
  end

  def initialize(base)
    @base = base
    @inspects = {
      Fixnum => Fixnum.instance_method(:inspect),
      Bignum => Bignum.instance_method(:inspect),
    }
  end

  def disable!
    @inspects.each do |klass, original|
      define_inspect klass, original
    end
  end

  def enable!
    @inspects.each do |klass, _original|
      define_inspect klass, Proc.new {
        Rin.instance.inspect_num self
      }
    end
  end

  # uhm... returns the base if no base is given
  # if base is given, it sets the base to that and calls the block
  def base(set_base=false, &block)
    return @base unless set_base
    temporary_base set_base, &block
  end

  def inspect_num(n)
    n.to_s(@base).upcase
  end

  def hex(&block)
    temporary_base 16, &block
  end

  def hex!
    @base = 16
  end

  def oct(&block)
    temporary_base 8, &block
  end

  def oct!
    @base = 8
  end

  def bin(&block)
    temporary_base 2, &block
  end

  def bin!
    @base = 2
  end

  def dec(&block)
    temporary_base 10, &block
  end

  def dec!
    @base = 10
  end

  private

  def define_inspect(klass, method_def)
    klass.class_eval do
      define_method :inspect, method_def
    end
  end

  def temporary_base(overriden_base, &block)
    initial_base = @base
    @base = overriden_base
    block.call
  ensure
    @base = initial_base
  end
end

rin.hex! if $0 == '-e' # stupid that accessing the var turns it on
