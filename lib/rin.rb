def rin
  Rin.instance
end

class Rin
  def self.instance
    @instance ||= new(10)
  end

  def initialize(base)
    @base = base
    override = Proc.new do
      define_method :inspect do
        Rin.instance.inspect_num self
      end
    end
    Fixnum.class_eval &override
    Bignum.class_eval &override
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

  def temporary_base(overriden_base, &block)
    initial_base = @base
    @base = overriden_base
    block.call
  ensure
    @base = initial_base
  end
end

rin.hex! if $0 == '-e' # stupid that accessing the var turns it on
