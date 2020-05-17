//
//  SignatureGeneration.swift
//  Created by Artyom Rudakov on 17.05.2020.
//

import BigInt

public extension DSA {
    typealias Signature = (r: BigUInt, s: BigUInt)
    
    func sign(
        _ message: String,
        with privateKey: Key,
        using parameters: Parameters
    ) -> Signature {
        let (q, p, g) = parameters.qpg, H = message.sha1Hash, x = privateKey
        var k: BigUInt = 0
        
        func rGenerator() -> BigUInt {
            k = (1..<q).randomElement()!
            return g.power(k, modulus: p)
        }
        func sGenerator(r: BigUInt) -> BigUInt {
            k.inverse(q)! * (H + x * r)
        }
        
        return twoGenerate(
            with: rGenerator,
            sGenerator,
            precondition: { $0 == 0 },
            predicate: { $0 != 0 }
        )
    }
}
