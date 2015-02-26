class Array
  #assumes array of arrays where the element is a number.
  def reverse_first_element
    new_arr = []
    self.each do |element|
      new_arr << [-element.last] + element[1..-1]
    end
    new_arr
  end

  def add_array(other_array)
    new_arr = []
    self.each_with_index do |elem, index|
      new_arr << elem + other_array[index]
    end
    new_arr
  end
end
