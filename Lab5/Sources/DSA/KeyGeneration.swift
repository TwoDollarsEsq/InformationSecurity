//
//  KeyGeneration.swift
//  Created by Artyom Rudakov on 17.05.2020.
//

import BigInt

public extension DSA {
    struct Parameters {
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
    
    typealias Key = BigUInt
    typealias Keys = (`public`: Key, `private`: Key)
    
    func keyPair(with parameters: Parameters = .init(with: 1024)) -> Keys {
        let (q, p, g) = parameters.qpg
        
        let 𝒙 = (1...q).randomElement()! // Private key
        let 𝐲 = g.power(𝒙, modulus: p)   // Public key
        
        return (𝒙, 𝐲)
    }
}

fileprivate extension DSA.Parameters {
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
        let gValue = (2...p - 2).randomElement()!.power((p - 1) / q, modulus: q)
        return gValue == 1 ? g(from: p, q) : gValue
    }
}
