import XCTest
@testable import Lab3

final class Lab3Tests: XCTestCase {
    let key = Data("correct-horse-battery-staple_go!".utf8)
    
    func testKeyTransform() {
        // Given
        let subkeys: [UInt32] = [
            1920102243, 762602341, 1936879464, 1633824101,
            1919251572, 1953705337, 1701605473, 560949087
        ]
        
        // When
        let result = transform(key)
        
        // Then
        XCTAssert(result == subkeys)
    }
    
    func testSubstitution() {
        // Given
        let subkeys = transform(key)
        let substituted: [UInt32] = [242, 248, 246, 248, 173, 171, 250, 211]
        
        // When
        let result = subkeys.map(substitute)
        
        // Then
        XCTAssert(result == substituted)
    }
    
    func testCoding() {
        // Given
        let message = "Hello, World!🤩"
        let data = Data(message.utf8)
        
        // When
        let encoded = try! encode(data, with: key)
        let decoded = try! decode(encoded, with: key)
        let encMessage = String(decoding: encoded, as: UTF8.self)
        let decMessage = String(decoding: decoded, as: UTF8.self)
        
        // Then
        XCTAssert(encoded != decoded)
        XCTAssert(message != encMessage)
        XCTAssert(decMessage.hasPrefix(message))
    }

    static var allTests = [
        ("testKeyTransform", testKeyTransform),
        ("testSubstitution", testSubstitution),
        ("testCoding", testCoding)
    ]
}
