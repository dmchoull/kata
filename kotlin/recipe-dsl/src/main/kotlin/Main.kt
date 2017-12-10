fun recipe(name: String, define: Recipe.() -> Unit): String {
    val recipe = Recipe(name)
    recipe.define()
    return recipe.toString()
}

class Recipe(private val name: String) {
    private val ingredients = mutableListOf<String>()
    private val steps = mutableListOf<String>()

    fun ingredient(name: String) {
        ingredients.add(name)
    }

    fun step(instruction: String) {
        steps.add(instruction)
    }

    override fun toString() = """
        |$name
        |${name.map { "=" }.joinToString(separator = "")}
        |
        |Ingredients
        |-----------
        |${ingredients.toBulletPoints()}
        |
        |Directions
        |----------
        |${steps.toNumberedList()}
    """.trimMargin()

    private fun <T> List<T>.toBulletPoints() = joinToString(separator = "\n") { " • $it" }

    private fun <T> List<T>.toNumberedList() =
            withIndex().joinToString(separator = "\n") { (index, step) -> " ${index + 1}) $step" }
}
