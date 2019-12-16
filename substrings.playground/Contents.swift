import UIKit

func substrings(n: String) -> Int {
    
    guard let number = Int(n) else { return 0 }
    var sizeN = n.count
    var d = number
    var sum = 0
    while d > 0 {
        let dCopy = d
        var m = 10
        for _ in 1...sizeN {
            sum = sum + dCopy % m
            m = m * 10
        }
        sizeN -= 1
        d = d / 10
    }

    sum = sum % Int(10e9 + 7)
    return sum
}

print(substrings(n: "123"))
