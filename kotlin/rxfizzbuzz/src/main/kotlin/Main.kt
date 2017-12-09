fun main(args: Array<String>) {
    (0..100).fizzBuzz()
            .subscribe({
                val message = when (it) {
                    is Fizz -> "Fizz"
                    is Buzz -> "Buzz"
                    is FizzBuzz -> "FizzBuzz"
                    is Value -> it.value
                }

                println(message)
            })
}
