//
//  KeyGeneration.swift
//  Created by Artyom Rudakov on 17.05.2020.
//

import BigInt

public struct DSAParameters {
    let q, p, g: BigUInt
    
    public init(with width: Int) {
        let 𝑳 = width, 𝑵 = min(𝑳, hashBitCount) - 1
        q = Self.q(with: 𝑵)
        p = Self.p(from: q, with: 𝑳)
        g = Self.g(from: p, q)
    }
    
    var qpg: (BigUInt, BigUInt, BigUInt) {
        (q, p, g)
    }
}

public func keyPair(
    with parameters: DSAParameters = .init(with: 1024)
) -> (`public`: BigUInt, `private`: BigUInt) {
    let (q, p, g) = parameters.qpg
    
    let 𝒙 = (1...q).randomElement()! // Private key
    let 𝐲 = g.power(𝒙, modulus: p)   // Public key
    
    return (𝒙, 𝐲)
}

fileprivate extension DSAParameters {
    static func generatePrime(with width: Int) -> BigUInt {
        while true {
            var random = BigUInt.randomInteger(withExactWidth: width)
            random |= BigUInt(1)
            if random.isPrime() {
                return random
            }
        }
    }

    static func q(with width: Int) -> BigUInt {
        generatePrime(with: width)
    }

    static func p(from q: BigUInt, with width: Int) -> BigUInt {
        while true {
            let potentialPrime = generatePrime(with: width)
            if (potentialPrime - 1).isMultiple(of: q) {
                return potentialPrime
            }
        }
    }

    static func g(from p: BigUInt, _ q: BigUInt) -> BigUInt {
        // FIXME: What if p < 2? In such rare cases — a crash.
        let gValue = (2...p - 2).randomElement()!.power((p - 1) / q, modulus: q)
        return gValue == 1 ? g(from: p, q) : gValue
    }
}
