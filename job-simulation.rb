require './Stack.rb'
require './Queue.rb'


# A company has six hiring positions with more people wanting jobs than the number of available positions.  The company will allow people to work in three-month intervals. The first six people on the waiting list will be hired in the order that they are on the waiting list.  The first six people will keep these positions for three months.  At the end of three months, the manager will roll a dice to determine the number of people who will lose their jobs. The company will use the policy of last-hired-first-fired.  For example, if the dice roll is 3, the last 3 people hired will lose their jobs to the first 3 people on the waiting list. People losing their jobs will be placed on the back of the waiting list in the order that they are fired. This process will continue for every three-month interval.


people_array = ["Ana", "Betty", "Cris", "Dany", "Eddie", "Fido", "Gina", "Holy", "Idan", "Juan"]
people_waiting_for_a_job = Queue.new
people_array.each { |person| people_waiting_for_a_job.enqueue(person) }

currently_employed_array = [nil,nil,nil,nil,nil,nil]
people_working = Stack.new
currently_employed_array.each { |one_spot| people_working.push(one_spot) }

def hire

  positions = 6

  positions.times do
    people_waiting_for_a_job.dequeue
  end
  people_waiting_for_a_job
  #=> #<Thread::Queue:0x007fc474a11400 @store=["Gina", "Holy", "Idan", "Juan"]>\
  trans = people_array.first(positions)
  # => ["Ana", "Betty", "Cris", "Dany", "Eddie", "Fido"]

  people_array = people_array.drop(positions)
  #=> ["Gina", "Holy", "Idan", "Juan"]

  positions.times do
    people_working.pop
  end
  people_working
  #=> #<Stack:0x007fc4741937b0 @store=[]>

  currently_employed_array.shift(positions)
  #=> []

  trans.first(positions).each do |one_spot|
    people_working.push(one_spot)
  end
  people_working

  currently_employed_array = trans
end


def time_pases

  positions_destiny = rand(1..people_working.size)

  #Fire people first from the Stack
  positions_destiny.times do
    people_working.pop
  end

  # Fire in the arrays
  trans = []
  positions_destiny.times do
    trans << currently_employed_array.pop
  end

  # put recentky fired to the  Queue and the aux array
  trans.each do |new_unemplyed|
    people_waiting_for_a_job.enqueue(new_unemplyed)
    people_array << new_unemplyed
  end

  #take the future employees  out of the  Queue and aux array
  positions_destiny.times do
    people_waiting_for_a_job.dequeue
  end

  trans =  people_array.shift(positions_destiny)

  #hire people to the Stack
  trans.each do |new_emplyed|
    people_working.push(new_emplyed)
    currently_employed_array.push(new_emplyed)
  end


end
