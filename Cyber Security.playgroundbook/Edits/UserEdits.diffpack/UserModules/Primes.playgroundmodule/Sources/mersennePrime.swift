import func Foundation.pow

public func mersennePrime(for p: UInt) -> Double {
    guard p >= 2 else { return 0 }
    
    let upperIndex = p - 1
    
    func 𝑀(for p: Double) -> Double {
        pow(2, p) - 1
    }
    func 𝑆(from previous: Double) -> Double {
        pow(previous, 2) - 1
    }
    func 𝑆(for current: Double = 4, index: UInt = 1) -> Double {
        index == upperIndex 
            ? current
            : 𝑆(for: 𝑆(from: current), index: index + 1)
    }
    
    var p = Double(p)
    var element = 𝑆()
    var prime = 𝑀(for: p)
//      while Int(element.truncatingRemainder(dividingBy: prime)) != 0 {
//          element.truncatingRemainder(dividingBy: prime)
//          element = 𝑆(from: element)
//          prime = 𝑀(for: p)
//          p += 1
//      }
    
    return prime
}

