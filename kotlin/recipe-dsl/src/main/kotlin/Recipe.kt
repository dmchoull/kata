fun recipe(name: String, define: Recipe.() -> Unit): String {
    val recipe = Recipe(name)
    recipe.define()
    return recipe.toString()
}

class Recipe(private val name: String) {
    private val _ingredients = mutableListOf<String>()
    private val _steps = mutableListOf<String>()

    fun ingredients(build: RecipeBuilder.() -> Unit) {
        val builder = RecipeBuilder()
        builder.build()
        _ingredients.addAll(builder.getAll())
    }

    fun steps(build: RecipeBuilder.() -> Unit) {
        val builder = RecipeBuilder()
        builder.build()
        _steps.addAll(builder.getAll())
    }

    class RecipeBuilder {
        private val _added: MutableList<String> = mutableListOf()

        operator fun String.unaryPlus() {
            _added.add(this)
        }

        fun getAll() = _added
    }

    override fun toString() = """
        |$name
        |${name.map { "=" }.joinToString(separator = "")}
        |
        |Ingredients
        |-----------
        |${_ingredients.toBulletPoints()}
        |
        |Directions
        |----------
        |${_steps.toNumberedList()}
    """.trimMargin()

    private fun <T> List<T>.toBulletPoints() = joinToString(separator = "\n") { " • $it" }

    private fun <T> List<T>.toNumberedList() =
            withIndex().joinToString(separator = "\n") { (index, step) -> " ${index + 1}) $step" }
}
