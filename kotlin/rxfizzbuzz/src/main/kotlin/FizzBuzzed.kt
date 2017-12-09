sealed class FizzBuzzed {
    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false
        return true
    }

    override fun hashCode(): Int {
        return javaClass.hashCode()
    }
}

data class Value(val value: String) : FizzBuzzed()

class Fizz : FizzBuzzed()

class Buzz : FizzBuzzed()

class FizzBuzz : FizzBuzzed()
