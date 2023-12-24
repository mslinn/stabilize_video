module Arithmetic
  # From https://stackoverflow.com/a/72129067
  # Evaluate a string representation of an arithmetic formula provided only these operations are expected:
  #   + | Addition
  #   - | Subtraction
  #   * | Multiplication
  #   / | Division
  #
  # Also assumes only integers are given for numerics.
  # Not designed to handle division by zero.
  #
  # Example input:   '20+10/5-1*2'
  # Expected output: 20.0
  def calculate(string) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    add_split      = string.split('+')
    subtract_split = add_split.map { |v| v.split('-') }
    divide_split   = subtract_split.map do |i|
      i.map { |v| v.split('/') }
    end
    multiply_these = divide_split.map do |i|
      i.map do |j|
        j.map { |v| v.split('*') }
      end
    end

    divide_these = multiply_these.each do |i|
      i.each do |j|
        j.map! do |k, l|
          if l.nil?
            k.to_i
          else
            k.to_i * l.to_i
          end
        end
      end
    end

    subtract_these = divide_these.each do |i|
      i.map! do |j, k|
        if k.nil?
          j.to_i
        else
          j / k.to_f
        end
      end
    end

    add_these = subtract_these.map! do |i, j|
      if j.nil?
        i.to_f
      else
        i.to_f - j.to_f
      end
    end

    add_these.sum
  end
end
