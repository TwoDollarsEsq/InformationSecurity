import XCTest
@testable import Lab3

final class Lab3Tests: XCTestCase {
    let key = Data("this_is_a_pasw_for_GOST_28147_89".utf8)
    
    func testExample() {
        
    }
    
    func testKeyTransform() {
        // Given
        let subkeys: [UInt32] = [
            1936287860, 1601399135, 1634754401, 1717532531,
            1197437551, 1599361871, 875640882, 959995703
        ]
        
        // When
        let result = transform(key)
        
        // Then
        XCTAssert(result == subkeys)
    }
    
    func testSubstitution() {
        // Given
        let subkeys = transform(key)
        let substituted: [UInt32] = [116, 95, 97, 115, 111, 79, 50, 55]
        
        // When
        let result = subkeys.map(substitute)
        
        // Then
        XCTAssert(result == substituted)
    }
    
    func testUncoding() {
        // Given
        let message = "Hello, World!"
        let data = Data(message.utf8)
        
        // When
        let encoded = encode(data, key: key)
        let string = String(decoding: encoded, as: UTF8.self)
        let decoded = decode(encoded, key: key)
        let decMessage = String(decoding: decoded, as: UTF8.self)
        
        // Then
        data.forEach { print($0, terminator: ", ") }
        print("")
        decoded.forEach { print($0, terminator: ", ") }
        print("")
        print(encoded, string)
        print(decoded, decMessage)
    }

    static var allTests = [
        ("testExample", testExample),
        ("testKeyTransform", testKeyTransform),
    ]
}
