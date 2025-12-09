import java.io.File
import org.junit.jupiter.api.Test
import org.junit.jupiter.api.Assertions.assertEquals

class SolutionTest {
    private val exampleInput = File("example.txt").readText()

    @Test
    fun `test part 1 with example`() {
        val result = solvePart1(exampleInput)

        assertEquals(21, result)
    }

    @Test
    fun `test part 2 with example`() {
        val result = solvePart2(exampleInput)
        assertEquals(40, result)
    }
}
