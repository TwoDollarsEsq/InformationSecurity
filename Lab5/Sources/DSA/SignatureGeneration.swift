//
//  SignatureGeneration.swift
//  Created by Artyom Rudakov on 17.05.2020.
//

import BigInt
import CryptoKit
import struct Foundation.Data

let hashBitCount = 160

extension Insecure.SHA1Digest {
    var bigInt: BigUInt { withUnsafeBytes(BigUInt.init) }
}

public func sign(
    _ message: String,
    with parameters: DSAParameters,
    _ keys: Keys
) -> (r: BigUInt, s: BigUInt) {
    let (q, p, g) = parameters.qpg, x = keys.private
    var hasher = Insecure.SHA1()
    var k: BigUInt = 0
    
    hasher.update(data: Data(message.utf8))
    let H = hasher.finalize().bigInt
    
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
