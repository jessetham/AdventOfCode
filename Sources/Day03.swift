//
//  Day03.swift
//  AdventOfCode
//
//  Created by Jesse Tham on 12/2/25.
//

struct Day03: AdventDay {
  let banks: [[UInt]]

  init(data: String) {
    self.banks =
      data
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .components(separatedBy: .newlines)
      .map { bank in bank.map { c in UInt(c.wholeNumberValue!) } }
  }

  func part1() async throws -> UInt {
    var sum: UInt = 0
    for bank in banks {
      sum += getMaxJolt(bank: bank, maxBatteries: 2)
    }
    return sum
  }

  func part2() async throws -> UInt {
    var sum: UInt = 0
    for bank in banks {
      sum += getMaxJolt(bank: bank, maxBatteries: 12)
    }
    return sum
  }

  private func getMaxJolt(bank: [UInt], maxBatteries: UInt) -> UInt {
    var res: [UInt] = []
    for (i, batt) in bank.enumerated() {
      let remainingBatteries = bank.count - i
      while let lastBatt = res.last,
        lastBatt < batt,
        res.count + remainingBatteries > maxBatteries
      {
        _ = res.popLast()
      }
      if res.count < maxBatteries {
        res.append(batt)
      }
    }
    return res.toUInt()
  }
}

extension [UInt] {
  func toUInt() -> UInt {
    var res: UInt = 0
    for num in self {
      res = (res * 10) + UInt(num)
    }
    return res
  }
}
