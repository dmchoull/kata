import org.amshove.kluent.shouldEqual
import org.jetbrains.spek.api.Spek
import org.jetbrains.spek.api.dsl.describe
import org.jetbrains.spek.api.dsl.it
import org.jetbrains.spek.api.dsl.on

object ScoreCardTest : Spek({
    describe("adding a frame") {
        on("an empty score card") {
            val scoreCard = ScoreCard()

            it("has an initial score of 0") {
                scoreCard.score shouldEqual 0
            }

            it("returns a new score card with the frame added") {
                val frame = Frame(1, 2)
                val newScoreCard = scoreCard + frame
                newScoreCard.frames shouldEqual listOf(frame)
            }

            it("has the new frame's score") {
                val newScoreCard = scoreCard + Frame(1, 2)
                newScoreCard.score shouldEqual 3
            }
        }

        on("a score card with a previous frame") {
            val originalFrame = Frame(1, 2)
            val scoreCard = ScoreCard(listOf(originalFrame))

            it("returns a new score card with both frames") {
                val frame = Frame(2, 3)
                val newScoreCard = scoreCard + frame
                newScoreCard.frames shouldEqual listOf(originalFrame, frame)
            }

            it("has the score for both frames") {
                val frame = Frame(2, 3)
                val newScoreCard = scoreCard + frame
                newScoreCard.score shouldEqual 8
            }
        }

        on("a score card with a spare as the most recent frame") {
            val spareFrame = Frame(8, 2)
            val scoreCard = ScoreCard(listOf(spareFrame))

            it("includes the first roll of the next frame as a bonus") {
                val newScoreCard = scoreCard + Frame(1, 2)
                newScoreCard.score shouldEqual 14
            }
        }

        on("a score card with a strike as the most recent frame") {
            val strikeFrame = Frame(10)
            val scoreCard = ScoreCard(listOf(strikeFrame))

            it("includes both rolls of the next frame as a bonus") {
                val newScoreCard = scoreCard + Frame(1, 2)
                newScoreCard.score shouldEqual 16
            }

            it("calculates the bonus for consecutive strikes") {
                val newScoreCard = scoreCard + Frame(10) + Frame(1, 2)
                newScoreCard.score shouldEqual 37
            }
        }
    }

    it("doesn't report an incomplete score for a spare") {
        val scoreCard = ScoreCard(listOf(Frame(1, 2), Frame(5, 5)))
        scoreCard.score shouldEqual 3
    }

    it("doesn't report an incomplete score for a strike") {
        val scoreCard = ScoreCard(listOf(Frame(1, 2), Frame(10)))
        scoreCard.score shouldEqual 3
    }

    it("scores a perfect game") {
        val frames = (1..10).map { if (it < 10) Frame(10) else Frame(10, 10, 10) }
        val scoreCard = ScoreCard(frames)

        scoreCard.score shouldEqual 300
    }
})
