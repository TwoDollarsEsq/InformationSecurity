//
//  Public.swift
//  Created by Artyom Rudakov on 09.05.2020.
//

import struct Foundation.Data

public func encode(_ message: Data, with key: Data) throws -> Data {
    try gost28147(message, with: key, encrypting: true)
}

public func decode(_ message: Data, with key: Data) throws -> Data {
    try gost28147(message, with: key, encrypting: false)
}
