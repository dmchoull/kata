import org.amshove.kluent.shouldEqual
import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.it
import org.jetbrains.spek.api.dsl.on

class MainTest : Spek({
    on("a simple recipe") {
        it("returns the formatted recipe") {
            recipe("Chocolate Fondue") {
                ingredients {
                    +"Chocolate"
                }

                steps {
                    +"Melt it"
                }

            } shouldEqual """
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
                ingredients {
                    +"1 1/2 cups macaroni"
                    +"6 ounces processed cheese, shredded"
                    +"1/2 cup shredded Cheddar cheese"
                    +"2 tablespoons heavy cream"
                    +"salt to taste"
                }

                steps {
                    +"Bring a large pot of lightly salted water to a boil."
                    +"Add pasta and cook for 8 to 10 minutes or until al dente."
                    +"Drain pasta."
                    +"Return drained pasta to the pot. Mix in processed cheese, Cheddar cheese, and cream."
                    +"Stir until cheeses melt."
                    +"Sprinkle with salt."
                }
            } shouldEqual """
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

    it("can add links to a recipe") {
        recipe("Chocolate Fondue") {
            ingredients { +"Chocolate" }
            steps { +"Melt it" }

            link("How to melt chocolate") to "https://www.youtube.com/watch?v=S20OLMrEmz8"
        } shouldEqual """
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
            |
            |Links
            |-----
            |<a href="https://www.youtube.com/watch?v=S20OLMrEmz8">How to melt chocolate</a>
        """.trimMargin()
    }
})
