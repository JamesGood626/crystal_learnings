# DOESN'T WORK
alias State = Normal | Parallel | Final

struct Normal 
    def initialize(@states : Array(State)) end # <- line 4
end

struct Parallel end
struct Final end

ps = [Parallel.new(), Final.new()] # .as(Array(State)) And can't be casted to Array(State)

puts typeof(ps) == Array(State) # is true

def log_it(xs : Array(State))
    puts "the xs: #{xs}"
end

log_it(ps)

puts Normal.new(ps) # What throws me off is that if this line is removed... the code compiles (but log_it has the same argument type declaration)

# OUTPUT:
# error in line 4
# Error: instance variable '@states' of Normal must be Array(Final | Normal | Parallel), not Array(Final | Parallel)

# DOES WORK
abstract struct State end

struct Normal < State
    def initialize(@states : Array(State)) end
end

struct Parallel < State end
struct Final < State end

ps = [Parallel.new(), Final.new()] # .as(Array(State)) Can be casted to Array(State)

puts typeof(ps) == Array(State) # is true

def log_it(xs : Array(State))
    puts "the xs: #{xs}"
end

log_it(ps)

puts Normal.new(ps)

# OUTPUT:
# true
# the xs: [Parallel(), Final()]
# Normal(@states=[Parallel(), Final()])
