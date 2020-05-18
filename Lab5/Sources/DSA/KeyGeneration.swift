//
//  KeyGeneration.swift
//  Created by Artyom Rudakov on 17.05.2020.
//

import BigInt

public extension DSA {
    struct Parameters {
        let q, p, g: BigUInt
        
        public init(q: BigUInt, p: BigUInt, g: BigUInt) {
            self.q = q
            self.p = p
            self.g = g
        }
        
        var qpg: (BigUInt, BigUInt, BigUInt) {
            (q, p, g)
        }
    }
    
    typealias Key = BigUInt
    typealias Keys = (`private`: Key, `public`: Key)
    
    static func keyPair(with parameters: Parameters) -> Keys {
        let (q, p, g) = parameters.qpg
        
        let 𝒙 = BigUInt.randomInteger(lessThan: q) // Private key
        let 𝐲 = g.power(𝒙, modulus: p)             // Public key
        
        return (𝒙, 𝐲)
    }
}

// TODO: Parameters generation
extension DSA.Parameters {
    init(widthOfP: Int) {
        let 𝑳 = widthOfP, 𝑵 = min(𝑳, hashBitCount) - 1
        q = Self.q(with: 𝑵)
        p = Self.p(from: q, with: 𝑳)
        g = Self.g(from: p, q)
    }
    
    init(q: BigUInt, p: BigUInt) {
        self.q = q
        self.p = p
        self.g = Self.g(from: q, p)
    }
    
    static func generatePrime(with width: Int) -> BigUInt {
        generate(
            with: { BigUInt.randomInteger(withExactWidth: width) | BigUInt(1)},
            predicate: { $0.isPrime() }
        )
    }

    static func q(with width: Int) -> BigUInt {
        generatePrime(with: width)
    }

    static func p(from q: BigUInt, with width: Int) -> BigUInt {
        generate(
            with: { generatePrime(with: width) },
            predicate: { ($0 - 1).isMultiple(of: q) }
        )
    }

    static func g(from p: BigUInt, _ q: BigUInt) -> BigUInt {
        let base = generate(
            with: { BigUInt.randomInteger(lessThan: p - 2) },
            predicate: { $0 > 1 }
        )
        let gValue = base.power((p - 1) / q, modulus: q)
        return gValue == 1 ? g(from: p, q) : gValue
    }
}
