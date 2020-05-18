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

extension BigUInt {
    static private let modulus: BigUInt =
        """
        113003610536769662365475438074349202902393371149098932488829763899759693\
        942182221311951893491037065838678290591836787867236266829425427477322203\
        921585701270997375076009060429934105831431797790713235693561718253840225\
        010037389994367689434248899226231330475152082648849936270434981210830874\
        017521600353881618277113003610536769662365475438074349202902393371149098\
        932488829763899759693942182221311951893491037065838678290591836787867236\
        266829425427477322203921585701270997375076009060429934105831431797790713\
        235693561718253840225010037389994367689434248899226231330475152082648849\
        936270434981210830874017521600353881618277
        """
    
    func power(_ exponent: BigUInt) -> BigUInt {
        self.power(exponent, modulus: Self.modulus)
    }
}
