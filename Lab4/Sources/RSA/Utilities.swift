//
//  Utilities.swift
//  Lab4
//

import BigInt

public func generatePrime(_ width: Int) -> BigUInt {
    while true {
        var random = BigUInt.randomInteger(withExactWidth: width)
        random |= BigUInt(1)
        if random.isPrime() {
            return random
        }
    }
}
