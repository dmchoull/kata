import org.amshove.kluent.`should equal`
import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.it
import org.jetbrains.spek.api.dsl.on

internal class MainTest : Spek({
    on("a simple recipe") {
        it("returns the formatted recipe") {
            recipe("Chocolate Fondue") {
                ingredient("Chocolate")
                step("Melt it")
            } `should equal` """
                |Chocolate Fondue
                |================
                |
                |Ingredients
                |-----------
                | • Chocolate
                |
                |Directions
                |----------
                | 1) Melt it
            """.trimMargin()
        }
    }

    on("a recipe with multiple steps and ingredients") {
        it("returns the formatted recipe") {
            recipe("Mac and Cheese") {
                ingredient("1 1/2 cups macaroni")
                ingredient("6 ounces processed cheese, shredded")
                ingredient("1/2 cup shredded Cheddar cheese")
                ingredient("2 tablespoons heavy cream")
                ingredient("salt to taste")

                step("Bring a large pot of lightly salted water to a boil.")
                step("Add pasta and cook for 8 to 10 minutes or until al dente.")
                step("Drain pasta.")
                step("Return drained pasta to the pot. Mix in processed cheese, Cheddar cheese, and cream.")
                step("Stir until cheeses melt.")
                step("Sprinkle with salt.")
            } `should equal` """
                |Mac and Cheese
                |==============
                |
                |Ingredients
                |-----------
                | • 1 1/2 cups macaroni
                | • 6 ounces processed cheese, shredded
                | • 1/2 cup shredded Cheddar cheese
                | • 2 tablespoons heavy cream
                | • salt to taste
                |
                |Directions
                |----------
                | 1) Bring a large pot of lightly salted water to a boil.
                | 2) Add pasta and cook for 8 to 10 minutes or until al dente.
                | 3) Drain pasta.
                | 4) Return drained pasta to the pot. Mix in processed cheese, Cheddar cheese, and cream.
                | 5) Stir until cheeses melt.
                | 6) Sprinkle with salt.
            """.trimMargin()
        }
    }
})
