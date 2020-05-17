//
//  SignatureGeneration.swift
//  Created by Artyom Rudakov on 17.05.2020.
//

import BigInt

public func sign(
    _ message: String,
    with parameters: DSAParameters,
    _ keys: Keys
) -> (r: BigUInt, s: BigUInt) {
    let (q, p, g) = parameters.qpg, H = message.sha1Hash, x = keys.private
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
