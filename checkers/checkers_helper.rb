class Array
  #assumes array of arrays where the element is a number.
  def reverse_first_element
    new_arr = []
    self.each do |element|
      new_arr << [-element.last] + element[1..-1]
    end
    new_arr
  end
end
