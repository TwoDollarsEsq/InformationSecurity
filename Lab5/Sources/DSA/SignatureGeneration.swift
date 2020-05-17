//
//  SignatureGeneration.swift
//  Created by Artyom Rudakov on 17.05.2020.
//

import BigInt
import CryptoKit

let hashBitCount = 160

extension Insecure.SHA1Digest {
    var bigInt: BigUInt { withUnsafeBytes(BigUInt.init) }
}
