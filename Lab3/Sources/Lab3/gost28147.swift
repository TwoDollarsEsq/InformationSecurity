//
//  gost28147.swift
//  Created by Artyom Rudakov on 09.05.2020.
//

import Foundation

enum GOSTError: Error {
    case invalidKey(message: String)
}

func gost28147(_ message: Data, with key: Data, encrypting: Bool) throws -> Data {
    guard key.count == 32 else {
        throw GOSTError.invalidKey(
            message: "Expected key length: 32, actual: \(key.count)"
        )
    }
    
    func process(_ block: Data, keys: [UInt32]) -> Data {
        var N1 = block[0..<4].uint32
        var N2 = block[4..<blockSize].uint32
        let level = encrypting ? 24 : 8
        
        for i in 0..<numberOfCycles {
            let index = i < level ? (i % 8) : (7 - i % 8)
            var s = (N1 + keys[index]) % UInt32.max
            s = substitute(s)
            s = (s << 11) | (s >> 21)
            s = s ^ N2
            
            if i < 31 {
                N2 = N1
                N1 = s
            } else {
                N2 = s
            }
        }
        
        return N1.data + N2.data
    }
    
    let diff = message.count % 8
    let message = message + Data(count: diff == 0 ? 0 : 8 - diff)
    let subKeys = transform(key)
    var result  = Data(count: message.count)
    var block   = Data(count: blockSize)
    
    for i in (0..<(message.count / blockSize)).map({ $0 * blockSize }) {
        block = Data(message[i..<(i + blockSize)])
        result[i..<(i + blockSize)] = process(block, keys: subKeys)
    }
    
    return result
}

func transform(_ key: Data) -> [UInt32] {
    (0..<8)
        .map { $0 * 4 }
        .map { $0..<($0 + 4) }
        .map { key[$0].uint32 }
}

func substitute(_ value: UInt32) -> UInt32 {
    var result = 0 as UInt32
    
    for i in 0..<8 as Range<UInt32> {
        var temp = UInt8((value >> (4 * i)) & 0x0f)
        temp = sBox[Int(i)][Int(temp)]
        result |= UInt32(temp << (4 * i))
    }
    
    return result
}
