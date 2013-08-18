class Array
  def insertion_sort!
    each_with_index do |value, current_index| #TODO iterate on index only - drop value
      insert_current_value(current_index)
    end
  end

  private
  def insert_current_value(current_index)
    current_value = self[current_index]
    (current_index - 1).downto(0) do |sorted_i|
      if current_value < self[sorted_i]
        self[sorted_i + 1] = self[sorted_i]
        self[sorted_i] = current_value
      else
        break
      end
    end
  end
end