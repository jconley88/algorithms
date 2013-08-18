class Array
  def quick_sort!(left = 0, right = self.length - 1)
    return self if right <= left# one element, nothing to sort
    pivot_index = select_pivot(left, right)
    pivot_value = self[pivot_index]
    move_pivot_to_end(pivot_index) #TODO  -is this necessary? can we just save the value in a var?
    insertion_point = 0
    left.upto(right - 1) do |i|
      insertion_point = i
      #I think that we should consider handling the eq case by moving it alongside the pivot
      if self[i] <= pivot_value #extract this to a comparison function?
        next
      else
        swap_with_smaller_value(i, right) || (replace_pivot(i) and break)
      end
    end
    quick_sort!(left, insertion_point - 1)
    quick_sort!(insertion_point + 1, right)
    return self
  end

  private

  def swap_with_smaller_value(i, right)
    successful = false
    smaller_index = find_index_of_value_smaller_than_pivot(i + 1, right - 1, self.last)
    if smaller_index # keep track of this index for future searching?
      swap_locations(i, smaller_index)
      successful = true
    end
    return successful
  end

  def replace_pivot(i)
    swap_locations(i, self.length - 1)
    return true
  end

  def find_index_of_value_smaller_than_pivot(first, last, pivot_value)
    (first).upto(last) do |k|
      if self[k] <= pivot_value #extract this to a comparison function?
        return k
      end
    end
    return nil
  end

  def select_pivot(left, right)
    rand(right - left) + left #TODO test this for a potential off-by-one error
  end

  def move_pivot_to_end(pivot_index)
    swap_locations(pivot_index, self.length - 1)
  end

  def swap_locations(i, j)
    tmp = self[i]
    self[i] = self[j]
    self[j] = tmp
  end
end