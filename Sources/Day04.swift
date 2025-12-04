//
//  Day04.swift
//  AdventOfCode
//
//  Created by Jesse Tham on 12/3/25.
//

struct Day04: AdventDay {
  let data: String

  func part1() async throws -> UInt {
    var grid = generateGrid()
    return markRemovals(&grid)
  }

  func part2() async throws -> UInt {
    var removed: UInt = 0
    var grid = generateGrid()
    while true {
      let marked = markRemovals(&grid)
      if marked == 0 {
        break
      }
      remove(&grid)
      removed += marked
    }
    return removed
  }

  private func generateGrid() -> [[Character]] {
    let rows =
      data
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .components(separatedBy: .newlines)
    return rows.map { row in Array(row) }
  }

  private func markRemovals(_ grid: inout [[Character]]) -> UInt {
    var count: UInt = 0
    for (i, row) in grid.enumerated() {
      for (j, c) in row.enumerated() {
        if c == "@" && countAround(grid, i, j) < 4 {
          grid[i][j] = "x"
          count += 1
        }
      }
    }
    return count
  }

  private func remove(_ grid: inout [[Character]]) {
    for (i, row) in grid.enumerated() {
      for j in row.indices {
        if grid[i][j] == "x" {
          grid[i][j] = "."
        }
      }
    }
  }

  func countAround(_ grid: [[Character]], _ i: Int, _ j: Int) -> UInt {
    let directions = [
      (1, 0), (0, 1), (-1, 0), (0, -1), (1, 1), (1, -1), (-1, 1), (-1, -1),
    ]
    var count: UInt = 0
    for (dr, dc) in directions {
      if let nei = grid[safe: i + dr]?[safe: j + dc], nei == "@" || nei == "x" {
        count += 1
      }
    }
    return count
  }
}
