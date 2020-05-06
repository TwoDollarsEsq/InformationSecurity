//
//  RSA.swift
//  Lab4
//

import BigInt

public typealias Key = (modulus: BigUInt, exponent: BigUInt)

public func generateKeyPair(
    of width: Int = 1024,
    with exponent: BigUInt = 65537
) -> (public: Key, private: Key) {
    let p = generatePrime(width), q = generatePrime(width), n = p * q
    let e = exponent, 𝜙 = (p - 1) * (q - 1), d = e.inverse(𝜙)!
    
    return ((n, e), (n, d))
}

public func encrypt(_ message: BigUInt, key: Key) -> BigUInt {
    message.power(key.exponent, modulus: key.modulus)
}
