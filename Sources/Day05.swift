//
//  Day05.swift
//  AdventOfCode
//
//  Created by Jesse Tham on 12/4/25.
//

struct Day05: AdventDay {
  let ranges: [[UInt64]]
  let availableIngredients: [UInt64]

  init(data: String) {
    let strs = data.trimmingCharacters(in: .whitespacesAndNewlines).split(
      separator: "\n\n"
    )
    ranges = Day05.buildRanges(String(strs[0]))
    availableIngredients = strs[1].components(separatedBy: .newlines).map {
      UInt64($0)!
    }
  }

  private static func buildRanges(_ input: String) -> [[UInt64]] {
    var nums = input.components(separatedBy: .newlines).map { line in
      line.split(separator: "-").map({ num in UInt64(num)! })
    }
    nums.sort(by: { (a, b) in
      if a[0] != b[0] { a[0] < b[0] } else { a[1] < b[1] }
    })
    var stack: [[UInt64]] = []
    for num in nums {
      if let last = stack.last, num[0] <= last[1] {
        _ = stack.popLast()
        stack.append([last[0], max(last[1], num[1])])
      } else {
        stack.append(num)
      }
    }
    return stack
  }

  private func isFresh(_ target: UInt64) -> Bool {
    var l = 0
    var r = ranges.count - 1

    while l <= r {
      let m = (r - l) / 2 + l
      let range = ranges[m]

      if range[0] <= target {
        if target <= range[1] {
          return true
        }
        l = m + 1
      } else {
        r = m - 1
      }
    }
    return false
  }

  func part1() async throws -> UInt64 {
    return UInt64(availableIngredients.count(where: { isFresh($0) }))
  }

  func part2() async throws -> UInt64 {
    var sum: UInt64 = 0
    for range in ranges {
      sum += range[1] - range[0] + 1
    }
    return sum
  }
}
