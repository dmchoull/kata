import io.reactivex.observers.TestObserver
import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.it

internal class FizzBuzzTest : Spek({
    it("fizzes and buzzes") {
        val fizzBuzzes = fizzBuzz(1..15)

        val testObserver = TestObserver<String>()
        fizzBuzzes.subscribe(testObserver)

        testObserver.assertValues("1", "2", "Fizz", "4", "Buzz", "Fizz", "7", "8",
                "Fizz", "Buzz", "11", "Fizz", "13", "14", "FizzBuzz")
    }
})
