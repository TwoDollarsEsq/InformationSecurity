//
//  Verification.swift
//  Created by Artyom Rudakov on 17.05.2020.
//

import BigInt

public extension DSA {
    static func verify(
        _ message: String,
        using parameters: Parameters,
        publicKey: Key,
        signature: Signature
    ) -> Bool {
        let (q, p, g) = parameters.qpg, (r, s) = signature
        let H = message.sha1Hash, y = publicKey
        guard r < q && s < q else { return false }
        
        let w = s.inverse(q)!
        let u1 = H * w % q, u2 = r * w % q
        
        let v1 = g.power(u1), v2 = y.power(u2)
        let v = v1 * v2 % p % q
        
        return v == r
    }
}
