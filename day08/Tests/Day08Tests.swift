import XCTest

@testable import day08

final class Day08Tests: XCTestCase {
    var exampleInput: String!

    override func setUp() {
        super.setUp()
        do {
            exampleInput = try String(contentsOfFile: "example.txt")
        } catch {
            XCTFail("Failed to read example.txt: \(error)")
        }
    }

    func testPart1() {
        let result = solvePart1(exampleInput)
        XCTAssertEqual(result, 40)
    }

    func testPart2() {
        let result = solvePart2(exampleInput)
        XCTAssertEqual(result, -1)  // TODO: Update with expected output
    }
}
