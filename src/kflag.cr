require "bit_array"

struct KFlag
  # differnt sizes for masks
  enum Masks
    Active = 0
    Admin  = 2
  end

  @data = 0

  def initialize
  end

  def check_admin : Bool
    @data & (1 << Masks::Admin.value) == 0 ? false : true
  end

  def set_admin : Nil
    @data = @data | 1 << Masks::Admin.value
    nil
  end

  def clear_admin : Nil
    @data = @data & ~(1 << Masks::Admin.value)
    nil
  end
end

macro kflag(name, *flags)
  struct {{name.id}}
    @data = 0

    {% for flag, index in flags %}
      def check_{{flag.id}} : Bool
        @data & (1 << {{index}}) == 0 ? false : true
      end

      def set_{{flag.id}} : Nil
        @data = @data | 1 << {{index}}
        nil
      end

      def clear_{{flag.id}} : Nil
        @data = @data & ~(1 << {{index}})
        nil
      end
    {% end %}
  end
end
