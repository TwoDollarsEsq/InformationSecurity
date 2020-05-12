//
//  Utilities.swift
//  Created by Artyom Rudakov on 09.05.2020.
//

import struct Foundation.Data

extension Data {
    var uint32: UInt32 {
        self.withUnsafeBytes { $0.load(as: UInt32.self) }
    }
}

extension UInt32 {
    var data: Data {
        var int = self
        return Data(bytes: &int, count: MemoryLayout<UInt32>.size)
    }
}

import SwiftUI
import PlaygroundSupport

extension View {
    public func embedIntoPlayground() {
        PlaygroundPage.current.liveView = UIHostingController(rootView: self)
    }
}

