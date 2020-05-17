//
//  Utilities.swift
//  Created by Artyom Rudakov on 17.05.2020.
//

public enum DSA {}

func generate<A>(with generator: () -> A, predicate: (A) -> Bool) -> A {
    while true {
        let newValue = generator()
        if predicate(newValue) {
            return newValue
        }
    }
}

func twoGenerate<A, B>(
    with aGenerator: () -> A,
    _ bGenerator: (A) -> B,
    precondition: (A) -> Bool,
    predicate: (B) -> Bool
) -> (A, B) {
    while true {
        let a = aGenerator()
        guard precondition(a) else { continue }
        
        let b = bGenerator(a)
        if predicate(b) { return (a, b) }
    }
}

import CryptoKit
import struct BigInt.BigUInt
import struct Foundation.Data

let hashBitCount = 160

extension Insecure.SHA1Digest {
    var bigInt: BigUInt { withUnsafeBytes(BigUInt.init) }
}

extension String {
    var sha1Hash: BigUInt {
        var hasher = Insecure.SHA1()
        hasher.update(data: Data(self.utf8))
        return hasher.finalize().bigInt
    }
}
