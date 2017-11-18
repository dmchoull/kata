class ScoreCard(val frames: List<Frame> = listOf()) {
    val score: Int = if (frames.isEmpty()) 0 else frames.foldIndexed(0, this::addFrameScore)

    private fun addFrameScore(frameIndex: Int, score: Int, frame: Frame): Int =
            score + frame.score(rollsAfter(frameIndex).toList())

    private fun rollsAfter(frameIndex: Int): Iterable<Int> =
            if (frameIndex == frames.lastIndex) {
                emptyList()
            } else {
                frames.subList(frameIndex + 1, frames.lastIndex + 1).flatMap { it.rolls }
            }

    operator fun plus(frame: Frame): ScoreCard = ScoreCard(frames + frame)
}

data class Frame(private val roll1: Int, private val roll2: Int, private val roll3: Int) {
    constructor(roll1: Int) : this(roll1, 0, 0)
    constructor(roll1: Int, roll2: Int) : this(roll1, roll2, 0)

    val rolls = listOf(roll1, roll2, roll3).filter { it > 0 }

    private val total = roll1 + roll2 + roll3
    private val isSpare = roll1 != 10 && total == 10
    private val isStrike = total == 10

    fun score(rolls: List<Int>): Int = when {
        !isSpare && !isStrike -> total
        isSpare && rolls.isNotEmpty() -> total + rolls.first()
        isStrike && rolls.size >= 2 -> total + rolls.take(2).sum()
        else -> 0
    }
}
