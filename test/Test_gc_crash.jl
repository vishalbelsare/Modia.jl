module Test_gc_crash

using Modia

@model FirstOrder begin
    x = Variable(start=1)   # start means x(0)
    T = Parameter(0.5)      # Time constant
    u = 2.0                 # Same as Parameter(2.0)
@equations begin
    T*der(x) + x = u        # der() means time derivative
    end
end;

for i in 1: 1000; println(i); result = simulate(FirstOrder, 2); end

end