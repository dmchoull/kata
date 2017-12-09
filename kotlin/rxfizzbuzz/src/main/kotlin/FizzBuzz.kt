import io.reactivex.Observable
import io.reactivex.ObservableSource
import io.reactivex.ObservableTransformer

fun Iterable<Int>.fizzBuzz(): Observable<FizzBuzzed> = Observable.fromIterable(this).compose(FizzBuzzTransformer())

class FizzBuzzTransformer : ObservableTransformer<Int, FizzBuzzed> {
    override fun apply(upstream: Observable<Int>): ObservableSource<FizzBuzzed> {
        return upstream.map {
            when {
                it.isFizzable() && it.isBuzzable() -> FizzBuzz()
                it.isFizzable() -> Fizz()
                it.isBuzzable() -> Buzz()
                else -> Value(it.toString())
            }
        }
    }
}

fun Int.isFizzable() = this % 3 == 0

fun Int.isBuzzable() = this % 5 == 0
