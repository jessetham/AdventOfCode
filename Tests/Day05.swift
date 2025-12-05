//
//  Day05.swift
//  AdventOfCode
//
//  Created by Jesse Tham on 12/4/25.
//

import Testing

@testable import AdventOfCode

struct Day05Tests {
  let testData: String = """
    3-5
    10-14
    16-20
    12-18

    1
    5
    8
    11
    17
    32
    """

  @Test func testPart1() async throws {
    let challenge = Day05(data: testData)
    #expect(try await challenge.part1() == 3)
  }

  @Test func testPart2() async throws {
    let challenge = Day05(data: testData)
    #expect(try await challenge.part2() == 14)
  }
}
