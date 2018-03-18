import java.net.URI

fun recipe(name: String, define: Recipe.() -> Unit): String {
    val recipe = Recipe(name)
    recipe.define()
    return recipe.toString()
}

class Recipe(private val name: String) {
    private val _ingredients = mutableListOf<String>()
    private val _steps = mutableListOf<String>()
    private val _links = mutableListOf<Link>()

    fun ingredients(build: RecipeBuilder.() -> Unit) {
        val builder = RecipeBuilder()
        builder.build()
        _ingredients.addAll(builder.items)
    }

    fun steps(build: RecipeBuilder.() -> Unit) {
        val builder = RecipeBuilder()
        builder.build()
        _steps.addAll(builder.items)
    }

    class RecipeBuilder {
        val items: MutableList<String> = mutableListOf()

        operator fun String.unaryPlus() {
            items.add(this)
        }
    }

    fun link(text: String) = Linker(text)

    inner class Linker(private val text: String) {
        infix fun to(url: String) {
            _links.add(Link(text, URI.create(url)))
        }
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
        |${_links.toSection("Links")}
    """.trimMargin().trim()

    private fun <T> List<T>.toBulletPoints() = joinToString(separator = "\n") { " • $it" }

    private fun <T> List<T>.toNumberedList() =
            withIndex().joinToString(separator = "\n") { (index, step) -> " ${index + 1}) $step" }

    private fun <T> List<T>.toSection(title: String): String {
        return if (isEmpty()) {
            ""
        } else {
            "\n$title\n-----\n${joinToString(separator = "\n")}\n"
        }
    }
}

data class Link(private val text: String, private val url: URI) {
    override fun toString() = """<a href="$url">$text</a>"""
}
