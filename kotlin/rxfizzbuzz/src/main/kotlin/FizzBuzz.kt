import io.reactivex.Observable

fun fizzBuzz(range: IntRange): Observable<String> {
    return Observable.fromIterable(range)
            .map { n ->
                when {
                    isFizzable(n) && isBuzzable(n) -> "FizzBuzz"
                    isFizzable(n) -> "Fizz"
                    isBuzzable(n) -> "Buzz"
                    else -> n.toString()
                }
            }
}

private fun isBuzzable(n: Int) = n % 5 == 0

private fun isFizzable(n: Int) = n % 3 == 0
