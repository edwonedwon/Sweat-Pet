
func sayHello() -> Void
{
    println("hello from function")
}

sayHello()

var sayHelloClosure: () -> Void =
{
    println("hello from closure")
}

sayHelloClosure()

sayHelloClosure = sayHello

sayHelloClosure()






// example from Kalin

func applyClosure( value : Int, operation : Int -> Int ) -> Int
{
    var result = operation( value )
    return result
}
var x = 2
var op_double = { n in n * 2 }
var op_triple = { n in n * 3 }
var double_x = applyClosure( x, op_double )
var triple_x = applyClosure( x, op_triple )

func notUsingClosure( n : Int ) -> Int
{
   return n*2
}

var double_x_other = applyClosure( x, notUsingClosure )



