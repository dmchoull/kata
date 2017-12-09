import io.reactivex.observers.TestObserver
import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.it

internal class FizzBuzzTest : Spek({
    it("fizzes and buzzes") {
        val fizzBuzzes = (0..15).fizzBuzz()

        val testObserver = TestObserver<FizzBuzzed>()
        fizzBuzzes.subscribe(testObserver)

        testObserver.assertValues(FizzBuzz(), Value("1"), Value("2"), Fizz(), Value("4"), Buzz(), Fizz(), Value("7"),
                Value("8"), Fizz(), Buzz(), Value("11"), Fizz(), Value("13"), Value("14"), FizzBuzz())
    }
})
