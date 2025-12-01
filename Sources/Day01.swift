//
//  Day01.swift
//  AdventOfCode
//
//  Created by Jesse Tham on 11/30/25.
//

struct Day01: AdventDay {
  var data: String

  var instructions: [Int] {
    let lines = data.trimmingCharacters(in: .whitespacesAndNewlines).components(
      separatedBy: .newlines
    )
    return lines.map { line in
      let clicks = Int(line.dropFirst())!
      if line.starts(with: "L") {
        return -clicks
      }
      return clicks
    }
  }

  func part1() async throws -> Int {
    var dial = 50
    var count = 0
    for instruction in instructions {
      dial = (dial + instruction) % 100
      if dial == 0 {
        count += 1
      }
    }
    return count
  }

  func part2() async throws -> Int {
    var dial = 50
    var count = 0
    for instruction in instructions {
      let sign = instruction.signum()
      for _ in 0..<abs(instruction) {
        dial = (dial + sign) % 100
        if dial == 0 {
          count += 1
        }
      }
    }
    return count
  }
}
