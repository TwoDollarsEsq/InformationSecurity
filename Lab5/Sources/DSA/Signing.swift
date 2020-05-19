//
//  Signing.swift
//  Created by Artyom Rudakov on 17.05.2020.
//

import BigInt

public extension DSA {
    struct Signature: Codable {
        public let r, s: BigUInt
        
        public init(_ r: BigUInt, _ s: BigUInt) {
            self.r = r
            self.s = s
        }
        
        var destructured: (r: BigUInt, s: BigUInt) {
            (r, s)
        }
    }
    
    static func sign(
        _ message: String,
        with privateKey: Key,
        using parameters: Parameters
    ) -> Signature {
        let (q, p, g) = parameters.qpg, H = message.sha1Hash, x = privateKey
        
        while true {
            let k = BigUInt.randomInteger(lessThan: q)
            guard k > 0 else { continue }
            
            let r = g.power(k, modulus: p) % q
            guard r > 0 else { continue }
            
            let s = k.inverse(q)! * (H + x * r) % q
            guard s > 0 else { continue }
            
            return .init(r, s)
        }
    }
}
