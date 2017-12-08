import io.reactivex.Observable

fun Iterable<Int>.fizzBuzz(): Observable<String> {
    return Observable.fromIterable(this)
            .map { it.toFizzBuzz() }
            .map { it.value }
}

data class FizzBuzz(val value: String)

fun Int.isFizzable() = this % 3 == 0

fun Int.isBuzzable() = this % 5 == 0

fun Int.toFizzBuzz(): FizzBuzz = when {
    isFizzable() && isBuzzable() -> FizzBuzz("FizzBuzz")
    isFizzable() -> FizzBuzz("Fizz")
    isBuzzable() -> FizzBuzz("Buzz")
    else -> FizzBuzz(toString())
}
