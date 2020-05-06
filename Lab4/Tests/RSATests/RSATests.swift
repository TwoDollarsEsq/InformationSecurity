import XCTest
import RSA
import BigInt

final class RSATests: XCTestCase {
    func testExample() {
        let (`public`, `private`) = generateKeyPair()
        print("Generated: \(`public`), \(`private`)")
        
        let message    = BigUInt(Data(
            """
            LizardScript is the future of mankind!🦎

            Check out LizardScript at github.com/killer-nyasha/lizardscript
            Copyright © 2020 Bydlosoft-Incorporated
            """.utf8))
        let cyphertext = encrypt(message,    key: `public`)
        let plaintext  = encrypt(cyphertext, key: `private`)
        let received   = String(decoding: plaintext.serialize(), as: UTF8.self)
        
        print(received)
        XCTAssert(message == plaintext)
    }

    static var allTests = [
        ("testExample", testExample)
    ]
}
