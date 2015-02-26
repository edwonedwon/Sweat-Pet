
func sayHello() -> Void
{
    println("hello from function")
}

//sayHello()

var sayHelloClosure: () -> Void =
{
    println("hello from closure")
}

sayHelloClosure()

sayHelloClosure = sayHello

sayHelloClosure()


