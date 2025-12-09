import Foundation

struct Point3D {
    var x: Int
    var y: Int
    var z: Int
}

struct Lowest {
    var id1: Int
    var id2: Int
    var distance: Float
}

func parseInput(_ input: String) -> [String] {
    return input.split(separator: "\n").map(String.init)
}

func euclidean(_ a: Point3D, _ b: Point3D) -> Float {
    var x = Float(b.x - a.x)
    x = x * x
    var y = Float(b.y - a.y)
    y = y * y
    var z = Float(b.z - a.z)
    z = z * z

    return sqrt(x + y + z)
}

func convertToPoints(_ line: String) -> Point3D {
    let splitted = line.split(separator: ",").map({ Int($0.trimmingCharacters(in: .whitespaces))! })
    return Point3D(x: splitted[0], y: splitted[1], z: splitted[2])
}

func solvePart1(_ input: String) -> Int {
    let lines = parseInput(input).map({ convertToPoints($0) })
    var junctions: [[Int]] = []
    var distances = Set<Float>()

    func findClosest() {
        var lowest = Lowest(id1: -1, id2: -1, distance: Float.infinity)

        for i in 0..<lines.count {
            for p in i + 1..<lines.count {
                let value = euclidean(lines[i], lines[p])
                if value < lowest.distance && !distances.contains(value) {
                    lowest = Lowest(id1: i, id2: p, distance: value)
                }
            }
        }

        if lowest.id1 == -1 {
            return
        }

        distances.insert(lowest.distance)
        if junctions.isEmpty {
            junctions.append([lowest.id1, lowest.id2])
        } else {
            var multipleJunctionsWithSame: [Int] = []
            for (index, junction) in junctions.enumerated() {
                if !multipleJunctionsWithSame.isEmpty {
                    if junction.contains(lowest.id1) || junction.contains(lowest.id2) {
                        multipleJunctionsWithSame.append(index)

                    }
                } else {
                    if junction.contains(lowest.id1) || junction.contains(lowest.id2) {
                        multipleJunctionsWithSame.append(index)
                        if junction.contains(lowest.id1) {
                            if !junctions[index].contains(lowest.id2) {
                                junctions[index].append(lowest.id2)
                            }
                        } else if junction.contains(lowest.id2) {
                            if !junctions[index].contains(lowest.id1) {
                                junctions[index].append(lowest.id1)
                            }
                        }
                    }
                }
            }

            if multipleJunctionsWithSame.count == 2 {
                var arrOne = junctions[multipleJunctionsWithSame[0]]
                let arrTwo = junctions[multipleJunctionsWithSame[1]]
                junctions.remove(at: multipleJunctionsWithSame[1])
                arrOne.append(contentsOf: arrTwo)
                junctions[multipleJunctionsWithSame[0]] = Array(Set(arrOne))
            }
            if multipleJunctionsWithSame.isEmpty {
                junctions.append([lowest.id1, lowest.id2])
            }
        }
    }

    for i in 0..<1000 {
        if i != 0 && i % 250 == 0 {
            print("INDEX \(i)")
        }
        findClosest()
    }

    junctions.sort(by: { $0.count > $1.count })
    return junctions[0].count * junctions[1].count * junctions[2].count
}

func solvePart2(_ input: String) -> Int {
    let lines = parseInput(input).map({ convertToPoints($0) })
    var lastJunction = Array(0..<lines.count)
    var junctions: [[Int]] = []
    var distances = Set<Float>()

    func findClosest() -> Lowest? {
        var lowest = Lowest(id1: -1, id2: -1, distance: Float.infinity)
        for i in 0..<lines.count {
            for p in i + 1..<lines.count {
                let value = euclidean(lines[i], lines[p])
                if value < lowest.distance && !distances.contains(value) {
                    lowest = Lowest(id1: i, id2: p, distance: value)
                }
            }
        }

        if lowest.id1 == -1 {
            return nil
        }

        distances.insert(lowest.distance)
        lastJunction = lastJunction.filter({ index in
            index != lowest.id1 && index != lowest.id2
        })
        if junctions.isEmpty {
            junctions.append([lowest.id1, lowest.id2])
        } else {
            var multipleJunctionsWithSame: [Int] = []
            // Check if the x or y of this combination already is in any junction
            for (index, junction) in junctions.enumerated() {
                if !multipleJunctionsWithSame.isEmpty {
                    if junction.contains(lowest.id1) || junction.contains(lowest.id2) {
                        multipleJunctionsWithSame.append(index)

                    }
                } else {
                    if junction.contains(lowest.id1) || junction.contains(lowest.id2) {
                        multipleJunctionsWithSame.append(index)
                        if junction.contains(lowest.id1) {
                            if !junctions[index].contains(lowest.id2) {
                                junctions[index].append(lowest.id2)
                            }
                        } else if junction.contains(lowest.id2) {
                            if !junctions[index].contains(lowest.id1) {
                                junctions[index].append(lowest.id1)
                            }
                        }
                    }
                }
            }

            if lastJunction.isEmpty && junctions.count == 1 {
                return lowest
            }

            if multipleJunctionsWithSame.count == 2 {
                var arrOne = junctions[multipleJunctionsWithSame[0]]
                let arrTwo = junctions[multipleJunctionsWithSame[1]]
                junctions.remove(at: multipleJunctionsWithSame[1])
                arrOne.append(contentsOf: arrTwo)
                junctions[multipleJunctionsWithSame[0]] = Array(Set(arrOne))
            }
            if multipleJunctionsWithSame.isEmpty {
                junctions.append([lowest.id1, lowest.id2])
            }
        }
        return nil
    }

    var lowest: Lowest?
    var i = 0
    while true {
        if i != 0 && i % 250 == 0 {
            print("I: \(i)")
        }
        lowest = findClosest()
        if lowest != nil {
            break
        }
        i = i + 1
    }

    return lines[lowest!.id1].x * lines[lowest!.id2].x
}

@main
struct Main {
    static func main() {
        do {
            let input = try String(contentsOfFile: "input.txt")
            print("Part 1: \(solvePart1(input))")
            print("Part 2: \(solvePart2(input))")
        } catch {
            print("Error reading file: \(error)")
        }
    }
}
