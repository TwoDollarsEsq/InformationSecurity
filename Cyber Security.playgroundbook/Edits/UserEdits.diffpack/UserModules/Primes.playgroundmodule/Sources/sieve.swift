public func sieveOld(_ numbers: [Int]) -> [Int] {
    if numbers.isEmpty { return [] }
    let prime = numbers[0]
    return [prime] + sieve(numbers[1..<numbers.count].filter { $0 % prime > 0 })
}

public func sieve(_ numbers: [Int], accumulator: [Int] = []) -> [Int] {
    if numbers.isEmpty { return accumulator }
    let prime = numbers[0]
    return sieve(numbers[1..<numbers.count].filter { $0 % prime > 0 }, accumulator: accumulator + [prime])
}

