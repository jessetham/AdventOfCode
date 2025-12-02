//
//  Day02.swift
//  AdventOfCode
//
//  Created by Jesse Tham on 12/1/25.
//

struct Day02: AdventDay {
  let ranges: [[UInt]]

  init(data: String) {
    self.ranges =
      data
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .split(separator: ",")
      .map { s in
        let range = s.split(separator: "-")
        return [UInt(range[0])!, UInt(range[1])!]
      }
  }

  func part1() async throws -> UInt {
    var sum: UInt = 0
    for range in ranges {
      for i in range[0]...range[1] {
        let strId = String(i)
        let strIdCount = strId.count
        if strIdCount % 2 != 0 {
          continue
        }
        if strId.prefix(strIdCount / 2) == strId.suffix(strIdCount / 2) {
          sum += i
        }
      }
    }
    return sum
  }

  func part2() async throws -> UInt {
    var sum: UInt = 0
    for range in ranges {
      for i in range[0]...range[1] {
        if self.isInvalid(id: i) {
          sum += i
        }
      }
    }
    return sum
  }

  private func isInvalid(id: UInt) -> Bool {
    let strId = String(id)
    let strIdCount = strId.count
    for i in 1..<strIdCount {
      if strIdCount % i != 0 {
        continue
      }
      let chunks = strId.chunks(ofCount: i).map { String($0) }
      let first = chunks.first!
      if chunks.allSatisfy({ $0 == first }) {
        return true
      }
    }
    return false
  }
}
