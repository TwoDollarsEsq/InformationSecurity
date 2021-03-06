# LAB4

У цій лабораторній роботі було необхідно програмно реалізувати алгоритм **RSA**. <br>
RSA — це алгоритм асиметричного шифрування, що тим чи іншим чином використовується у сьогоденні під час передачі повідомлень через інтернет.

## Лістінг
<span style="color:red">**Disclamer**:</span>
Цю реалізацію не слід використовувати у реальній криптографічній системі. Версія у цій роботі націлена на демонстрацію принципу алгоритму, а не на врахування усіх тонких(і не дуже) нюансів RSA.
<hr>
Ядро реалізації знаходиться у файлі RSA.swift
<br>
Тут знаходиться функція, що може коректно згенерувати пару з публічного й приватного ключа, генеруючи два простих числа заданої довжини в бітах та використовуючи функцію Ейлера.
<br>

```swift
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
    let e = exponent, 𝜙 = (p - 1) * (q - 1), d = e.inverse(𝜙)! // d * e % 𝜙 == 1
    
    return ((n, e), (n, d))
}
```

Крім того, у цьому файлі знаходиться функція `encrypt`. За допомогою неї можна як шифрувати так і дешифрувати, оскільки шифрування приватним ключем вихідне повідомлення.
```swift
public func encrypt(_ message: BigUInt, key: Key) -> BigUInt {
    message.power(key.exponent, modulus: key.modulus) // m^e % n
}
```

Тестовий приклад знаходиться у файлі `RSATests.swift`:
```swift
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
```
Оскільки зібрати Swift Package(формат проекту) не можна на кожній платформі, приведемо результат виконання тестового прикладу:
```
Test Suite 'All tests' started at 2020-05-06 11:54:59.597
Test Suite 'RSATests.xctest' started at 2020-05-06 11:54:59.598
Test Suite 'RSATests' started at 2020-05-06 11:54:59.598
Test Case '-[RSATests.RSATests testExample]' started.
Generated: (modulus: 18299882276849829975985334383810053803602958449069521652783896483357302208143311898329002478071715135496520434146681405060385532661768889263303626006434795411831710650161989340508436925202620260550602742593053603790646135467931951807297250091402679580172250462282288615064973253053872805257967897811478521381953297459471030050037336646724054580857304535275708049761925099189246393820860998988178943567067602557403575640046767945387490722466791460657961223964519894270086017720047773143670012765060865674480179122269667327168827494651621501891198337546287928133807974118327986839799223513994858068697777689815484591587, exponent: 65537), (modulus: 18299882276849829975985334383810053803602958449069521652783896483357302208143311898329002478071715135496520434146681405060385532661768889263303626006434795411831710650161989340508436925202620260550602742593053603790646135467931951807297250091402679580172250462282288615064973253053872805257967897811478521381953297459471030050037336646724054580857304535275708049761925099189246393820860998988178943567067602557403575640046767945387490722466791460657961223964519894270086017720047773143670012765060865674480179122269667327168827494651621501891198337546287928133807974118327986839799223513994858068697777689815484591587, exponent: 8619264936170415974162920209338980130454798379631017507333770490688820125440098748456896844425556598600890989231117713831941965946007325232764031426013233208300978750159456291298265575280444362767230807915564927320592412066834360565598845168704974491977921285224067091411349228302591600968963380527712879716950469464068050643416291605149235457136134073568318646944295373570735644425091809498970808499157282762791904996870519495092471406698235884477927342921590543149104086228199311363174453927923102616870829109585083094442422198948068750052587843976066239114779324984511977742722532412456231851491236182013974742817)
LizardScript is the future of mankind!🦎

Check out LizardScript at github.com/killer-nyasha/lizardscript
Copyright © 2020 Bydlosoft-Incorporated
Test Case '-[RSATests.RSATests testExample]' passed (146.966 seconds).
Test Suite 'RSATests' passed at 2020-05-06 11:57:26.565.
	 Executed 1 test, with 0 failures (0 unexpected) in 146.966 (146.967) seconds
Test Suite 'RSATests.xctest' passed at 2020-05-06 11:57:26.566.
	 Executed 1 test, with 0 failures (0 unexpected) in 146.966 (146.968) seconds
Test Suite 'All tests' passed at 2020-05-06 11:57:26.566.
	 Executed 1 test, with 0 failures (0 unexpected) in 146.966 (146.969) seconds
Program ended with exit code: 0
```

Видно, що розшифроване повідомлення еквівалентне вихідному, оскільки тест завершився успішно. Саме розшифроване повідомлення також виведене у консоль.