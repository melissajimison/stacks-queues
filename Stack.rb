#LIFO
class Stack
  def initialize
    @store = []
  end

  def pop
    @store.pop 
  end

  def push(element)
    @store.push element
  end

  def size
    @store.length
  end

  def empty?
    size == 0
  end
end
